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
#include "timedResponse.h"
#include "event_producer.h"
#include "nvm.h"
#include "canpan3Events.h"
#include "canpan3Inputs.h"
#include "canpan3Nv.h"
#include "nv.h"

static uint8_t buttonState[NUM_BUTTON_COLUMNS];
uint8_t outputState[NUM_BUTTONS];

static uint8_t column;  // Column number
uint8_t canpanScanReady;   /// indicates if the code has had chance to read all the buttons

#define MODE_UNKNOWN    0
#define MODE_ON_OFF     1
#define MODE_ONOFF_ONLY 2
#define MODE_TOGGLE     3
#define MODE_PAIR       4   // Odd switches
#define MODE_PAIRED     5   // Even switches

// forward declarations
void driveColumn(void);
uint8_t findEventForSwitch(uint8_t buttonNo);
TimedResponseResult sodTRCallback(uint8_t type, uint8_t serviceIndex, uint8_t step);
void canpanSendProducedEvent(uint8_t tableIndex, uint8_t onOff);
EventState getSwitchEventState(uint8_t switchNo);

/**
 * Initialise the input (buttons) circuitry.
 */
void initInputs(void) {
    uint8_t i;
    uint8_t startNv;
    
    canpanScanReady = 0;
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
    startNv = (uint8_t)getNV(NV_STARTUP);
    for (i=0; i<NUM_BUTTONS; i++) {
        if (!(startNv & NV_STARTUP_RESTORESWITCHES)) {
            outputState[i] = (uint8_t)readNVM(EEPROM_NVM_TYPE, EE_ADDR_SWITCHES+i);
        } else {
            outputState[i] = 0;     // default 0 but maybe loaded from EEPROM later
        }
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
    uint8_t switchMode;
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
            buttonNo = column*NUM_BUTTON_ROWS + i;  // 0 .. 31
            if (mode_flags & FLAG_MODE_LEARN) {
                // when in teach mode we actually send a ARON1 instead of the event
                sendMessage5(OPC_ARON1, nn.bytes.hi, nn.bytes.lo, 0, 0, buttonNo+1);
            } else {
                switchMode = MODE_UNKNOWN;
                tableIndex = findEventForSwitch(buttonNo & 0xFE);
                if (tableIndex != NO_INDEX) {
                    sv = (uint8_t)getNV(NV_SWITCHMODE + (buttonNo & 0xFE));
                    if (sv & NV_SWITCHMODE_PAIRED) {
                        switchMode = (buttonNo & 1) ? MODE_PAIRED : MODE_PAIR;
                    } else {
                        tableIndex = findEventForSwitch(buttonNo);
                    }
                } else {
                    tableIndex = findEventForSwitch(buttonNo);
                }
                
                if (tableIndex != NO_INDEX) {
                    getEVs(tableIndex);
                    sv = evs[EV_SWITCHSV];
                    if (switchMode == MODE_UNKNOWN) {
                        // determine the switch mode using the SV event variable
                        switchMode = MODE_UNKNOWN;
                        if (sv & SV_ON_OFF) {
                            switchMode = MODE_ON_OFF;
                        } else if (sv & SV_ON_ONLY) {
                            switchMode = MODE_ONOFF_ONLY;
                        } else if (sv & SV_TOGGLE) {
                            switchMode = MODE_TOGGLE;
                        }
                    }
                    // When in learn mode we'll act as if it is ON/OFF mode to send an ARON1
                    if (mode_flags & FLAG_MODE_LEARN) {
                        switchMode = MODE_ON_OFF;
                    }
                    if (switchMode != MODE_UNKNOWN){

                        switch(switchMode) {
                            case MODE_ON_OFF:
                                if (sv & SV_POLARITY) {   // invert
                                    onOff = !onOff;
                                }
                                outputState[buttonNo] = onOff;
                                break;
                            case MODE_ONOFF_ONLY:
                                if (sv & SV_POLARITY) {   // OFF ONLY
                                    if (! onOff) {    // don't send OFF event
                                        continue;
                                    }
                                    onOff = 0;      // make it an OFF event
                                } else {                // ON ONLY
                                    if (! onOff) {
                                        continue;   // don't send OFF event
                                    }
                                }
                                outputState[buttonNo] = onOff;
                                break;
                            case MODE_TOGGLE:
                                if (onOff) {
                                    outputState[buttonNo] = ! outputState[buttonNo];
                                } else {
                                    continue;   // don't react when button is released
                                }
                                onOff = outputState[buttonNo];
                                if ((getNV(NV_STARTUP) & NV_STARTUP_RESTORESWITCHES) == 0) {
                                    EEPROM_WriteNoVerify(EE_ADDR_SWITCHES + buttonNo, outputState[buttonNo]);
                                }
                                break;
                            case MODE_PAIR:
                                if (! onOff) {
                                    continue;
                                }
                                outputState[buttonNo] = 1;
                                break;
                            case MODE_PAIRED:
                                if (! onOff) {
                                    continue;
                                }
                                onOff = 0;  // force off
                                outputState[buttonNo&0xFE] = 0;
                                break;
                        }
                        
                        if (canpanScanReady) {
                            // send the event.
                            canpanSendProducedEvent(tableIndex, onOff);
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
        canpanScanReady = 1;
        column=0;
    }
    driveColumn();
}


/**
 * Used at initialisation if NV1 = ALLOFF. Turns off (or on if inverted) all 
 * the switch output states.
 */
void canpanSetAllSwitchOff(void) {
    uint8_t buttonNo;
    uint8_t tableIndex;
    
    for (buttonNo=0; buttonNo<NUM_BUTTONS; buttonNo++) {
        tableIndex = findEventForSwitch(buttonNo);
        getEVs(tableIndex);
        outputState[buttonNo] = (evs[EV_SWITCHSV]&SV_POLARITY) ? 1:0;
    }
}

void canpanSendProducedEvent(uint8_t tableIndex, uint8_t onOff) {
    uint8_t opc;
    Word producedEventNN;
    Word producedEventEN;
    
    producedEventNN.word = getNN(tableIndex);
    producedEventEN.word = getEN(tableIndex);
    if (producedEventNN.word == 0) {
        // Short event
        if (onOff) {
            opc = OPC_ASON;
        } else {
            opc = OPC_ASOF;
        }
        producedEventNN.word = nn.word;
    } else {
        // Long event
        if (onOff) {
            opc = OPC_ACON;
        } else {
            opc = OPC_ACOF;
        }
    }

    sendMessage4(opc, producedEventNN.bytes.hi, producedEventNN.bytes.lo, 
            producedEventEN.bytes.hi, producedEventEN.bytes.lo);

    incrementProducerCounter();
}

void driveColumn(void) {
    LATAbits.LATA0 = (column & 0x01)?1:0;
    LATAbits.LATA1 = (column & 0x02)?1:0;
    LATAbits.LATA2 = (column & 0x04)?1:0;
}

/**
 * Get the table index for the switch number (0..NUM_BUTTONS-1).
 * Uses the quick lookup table switch2Event which is maintained in canpan3Events.c
 * @param switchNo
 * @return 
 */
uint8_t findEventForSwitch(uint8_t switchNo) {
    if (switchNo < NUM_PRODUCED_EVENTS) {
        return switch2Event[switchNo];
    }
    return NO_INDEX;
}

/**
 * Do the start of day by sending the current state of all produced events.
 * Use TimedResponse so we don't overload the bus.
 * This sets things up so that timedResponse will call back into APP_doSOD() 
 * whenever another response is required.
 */
void doSoD(void) {
    if (!timedResponseInProgress()) {
        startTimedResponse(TIMED_RESPONSE_SOD, findServiceIndex(SERVICE_ID_PRODUCER), sodTRCallback);
    }
}

/**
 * Send one response CBUS message and increment the step counter ready for the next call.
 * 
 * Here I use step 0 to 254 to go through all possible events.
 *  
 * This is the callback used by the start of day responses.
 * @param type always set to TIMED_RESPONSE_SOD
 * @param serviceIndex indicates the service requesting the responses
 * @param step loops through each event tableIndex
 * @return whether all of the responses have been sent yet.
 */
TimedResponseResult sodTRCallback(uint8_t type, uint8_t serviceIndex, uint8_t tableIndex) {
    EventState value;
    uint8_t sv;

    if (tableIndex >= NUM_EVENTS) {
        return TIMED_RESPONSE_RESULT_FINISHED;
    }
    // The step is used to index through the events 
    value = APP_GetEventIndexState(tableIndex);
    
    if (value != EVENT_UNKNOWN) {
        sv = evs[EV_SWITCHSV];
        if (!(sv & SV_ONLY)) { // Don't send ON ONLY nor OFF ONLY
            canpanSendProducedEvent(tableIndex, value==EVENT_ON);
        }
    }
    return TIMED_RESPONSE_RESULT_NEXT;
}
