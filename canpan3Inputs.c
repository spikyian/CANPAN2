/*
  This work is licensed under the:
      Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
   To view a copy of this license, visit:
      http://creativecommons.org/licenses/by-nc-sa/4.0/
   or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.

   License summary:
    You are free to:
      Share, copy and redistribute the material in any medium or format
      Adapt, remix, transform, and build upon the material

    The licensor cannot revoke these freedoms as long as you follow the license terms.

    Attribution : You must give appropriate credit, provide a link to the license,
                   and indicate if changes were made. You may do so in any reasonable manner,
                   but not in any way that suggests the licensor endorses you or your use.

    NonCommercial : You may not use the material for commercial purposes. **(see note below)

    ShareAlike : If you remix, transform, or build upon the material, you must distribute
                  your contributions under the same license as the original.

    No additional restrictions : You may not apply legal terms or technological measures that
                                  legally restrict others from doing anything the license permits.

   ** For commercial use, please contact the original copyright holder(s) to agree licensing terms

    This software is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE
 */
/**
 *	The CANPAN program.
 *
 * @author Ian Hogg 
 * @date October 2024
 * 
 */ 
#include <xc.h>
#include "module.h"
#include "mns.h"
#include "event_teach.h"
#include "canpan3Events.h"

static uint8_t buttonState[NUM_BUTTON_COLUMNS];
uint8_t outputState[NUM_BUTTONS];

static uint8_t column;  // Column number
static uint8_t ready;   /// indicates if the code has had chance to read all the buttons

#define MODE_UNKNOWN    0
#define MODE_ON_OFF     1
#define MODE_ONOFF_ONLY 2
#define MODE_TOGGLE     3

// forward declarations
void driveColumn(void);
uint8_t findEventForSwitch(uint8_t buttonNo);

/**
 * Initialise the input (buttons) circuitry.
 */
void initInputs(void) {
    uint8_t i;
    ready = 0;
    // Column drivers
    TRISAbits.TRISA0=0;
    TRISAbits.TRISA1=0;
    TRISAbits.TRISA2=0;
    // Row inputs
    TRISBbits.TRISB0=1;
    TRISBbits.TRISB1=1;
    TRISCbits.TRISC0=1;
    TRISCbits.TRISC1=1;
    
#if defined(_18F66K80_FAMILY_)
    INTCON2.RPBU = 0x0; // enable pull-ups
    WPUB = 0xFF;
#endif
#if defined(_18FXXQ83_FAMILY_)
    WPUB = 0b00000011;    // enable pull-ups
    WPUC = 0b00000011;
#endif
    // start the column outputs
    column = 0;
    driveColumn();
    for (i=0; i<NUM_BUTTONS; i++) {
        outputState[i] = 0;
    }
    for (i=0; i<NUM_BUTTON_COLUMNS; i++) {
        buttonState[i] = 0;
    }
}

/**
 * Scan the input buttons. Gets called every 2ms from the main loop. Each scan handles 1 row of 4 switches.
 * 8 scans are needed for a scan of all buttons taking 16ms.
 * For switches/buttons EV#1 must be set to 1. EV#2 is switch number. EV#3 is the switch mode
 */
void inputScan(void) {
    uint8_t row;
    uint8_t i;
    uint8_t diff;
    uint8_t tableIndex;
    uint8_t sv;
    uint8_t mode;
    uint8_t onOff;
    uint8_t buttonNo;
    Word producedEventNN;
    Word producedEventEN;
    uint8_t opc;

    
    // read the row
    row = (uint8_t)((PORTC & 0x03) << 2);
    row |= (PORTB & 0x03);  // get the row value
    diff = row ^ buttonState[column];   // has the row changed since last read?
    
    // work out what has changed since last read.
    // Go through the bits of the row
    for (i=0; i<NUM_BUTTON_ROWS; i++) {
        if (diff & (1 << i)) {
            // has this particular switch changed?
            onOff = !!(row & (1 << i));
            buttonNo = column*NUM_BUTTON_ROWS + i;
            tableIndex = findEventForSwitch(buttonNo);
            if (tableIndex != NO_INDEX) {
                sv = evs[EV_SWITCHSV];
                // determine the switch mode using the SV event variable
                mode = MODE_UNKNOWN;
                if (sv & 0b0001) {
                    mode = MODE_ON_OFF;
                } else if (sv & 0b0100) {
                    mode = MODE_ONOFF_ONLY;
                } else if (sv & 0b1000) {
                    mode = MODE_TOGGLE;
                }
                // When in learn mode we'll act as if it is ON/OFF mode to send an ARON1
                if (mode_flags & FLAG_MODE_LEARN) {
                    mode = MODE_ON_OFF;
                }
                if (mode != MODE_UNKNOWN){

                    switch(mode) {
                        case MODE_ON_OFF:
                            if (sv & 0b0010) {   // invert
                                onOff = ~onOff;
                            }
                            outputState[buttonNo] = onOff;
                            break;
                        case MODE_ONOFF_ONLY:
                            if (sv & 0b0010) {   // invert
                                if (onOff) {    // don't send ON event
                                    continue;
                                }
                            } else {
                                if (! onOff) {
                                    continue;   // don't send OFF event
                                }
                            }
                            outputState[buttonNo] = onOff;
                            break;
                        case MODE_TOGGLE:
                            if (onOff) {
                                outputState[buttonNo] = ~outputState[buttonNo];
                            }
                            onOff = outputState[buttonNo];
                            break;
                    }
                    if (ready) {
                        producedEventNN.word = getNN(tableIndex);
                        producedEventEN.word = getEN(tableIndex);
                        if ((sv & 0b100000) || (producedEventNN.word == 0)) {
                            // Short event
                            if (onOff == EVENT_ON) {
                                opc = OPC_ASON;
                            } else {
                                opc = OPC_ASOF;
                            }
                            producedEventNN.word = nn.word;
                        } else {
                            // Long event
                            if (onOff == EVENT_ON) {
                                opc = OPC_ACON;
                            } else {
                                opc = OPC_ACOF;
                            }
                        }
                        if (mode_flags & FLAG_MODE_LEARN) {
                            sendMessage5(OPC_ARON1, producedEventNN.bytes.hi, producedEventNN.bytes.lo, 
                                    producedEventEN.bytes.hi, producedEventEN.bytes.lo, buttonNo+1);
                        } else {
                            sendMessage4(opc, producedEventNN.bytes.hi, producedEventNN.bytes.lo, 
                                    producedEventEN.bytes.hi, producedEventEN.bytes.lo);
                        }
                    }
                }
            }
        }
    }
    // save the state
    buttonState[column] = row;
    
    // Output the column driver
    column++;
    if (column >= NUM_BUTTON_COLUMNS) {
        // After 1 scan we'll be ready to send events
        ready = 1;
        column=0;
    }
    driveColumn();
}

void driveColumn(void) {
    LATAbits.LATA0 = (column & 0x01)?1:0;
    LATAbits.LATA1 = (column & 0x02)?1:0;
    LATAbits.LATA2 = (column & 0x04)?1:0;
}

uint8_t findEventForSwitch(uint8_t switchNo) {
    uint8_t tableIndex;
    for (tableIndex=0; tableIndex < NUM_EVENTS; tableIndex++) {
        getEVs(tableIndex);
        if (evs[EV_TYPE] == CANPAN_PRODUCED) {
            if (evs[EV_SWITCHNO] == switchNo+1) {
                return tableIndex;
            }
        }
    }
    return NO_INDEX;
}