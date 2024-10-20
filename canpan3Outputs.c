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
#include "canpan3Outputs.h"

// RB4 - RB7 are used to drive the LED Anodes
// MSSP SSI Master is used to provide 8 bits for cathodes

static unsigned char current_row = 0;
unsigned char ledMatrix[NUM_LED_ROWS];
enum canpan3LedState ledStates[NUM_LEDS];
//uint8_t outputState[NUM_LEDS];

void initOutputs(void) {
    uint8_t i;
    
    for (i=0; i<NUM_LEDS; i++) {
        ledStates[i] = CANPANLED_OFF;
        outputState[i] = 0;
    }
    for (i=0; i< NUM_LED_ROWS; i++) {
        ledMatrix[i] = 0;
    }
    TRISCbits.TRISC6 = 0;   // anode driver output
    TRISCbits.TRISC7 = 0;   // anode driver output
    TRISBbits.TRISB6 = 0;   // anode driver output
    TRISBbits.TRISB7 = 0;   // anode driver output
    
    LATBbits.LATB6 = 0;    // LED anode drivers off
    LATBbits.LATB7 = 0;
    LATCbits.LATC6 = 0;
    LATCbits.LATC7 = 0;
    
    // Cathode driver output enable
    TRISCbits.TRISC2 = 0;
    LATCbits.LATC2 = 1;     // disabled.
    
    // latch
    TRISCbits.TRISC4 = 0;
    LATCbits.LATC4 = 0;     // disabled.
    
    //Set up the MSSP to drive the switch matrix
    TRISCbits.TRISC3 = 0;
    TRISCbits.TRISC5 = 0;
    
    SPI1CON0 = 0x03; // MSb first, host mode, Total bit count Mode, transmit only
    SPI1CON1 = 0;   // SSP=0 for active high and latches when it goes low
    SPI1TCNT=1;     // 1 byte
    SPI1TWIDTH=0;   // 8 bits
    SPI1CON1 = 0x04; // SSP is active low
    SPI1CON2 = 0x00; // receiver off
    SPI1CLK = 0x00; // Clock from Fosc
    SPI1BAUD = 31;  // Fosc/64

    // set up PPS to the correct pins
    RC5PPS = 0x32; // SPI1SDO
    RC3PPS = 0x34; // SPI1SCK
    RC4PPS = 0x33; // SPI1SS, latch

    // ready
    SPI1CON0bits.EN = 1;
    
    // Set up TMR2 to generate interrupt every 2ms
    T2CONbits.CKPS = 5;     // clock prescalar 1:32
    T2CONbits.OUTPS = 0;    // clock postscalar 1:1
    T2CLKCON = 1;           // Fosc/4 clock source
    T2PR = 250;             // duration
    T2HLTbits.MODE = 0;     // free run mode
    
    PIR3bits.TMR2IF = 0;    // no outstanding interrupt
    PIE3bits.TMR2IE = 1;    // enable interrupts
    T2CONbits.ON = 1;       // enable timer
}

// Called every 2ms
#if defined(_18F66K80_FAMILY_)
void outputIsr(void) 
#endif
#if defined(_18FXXQ83_FAMILY_)
void __interrupt(irq(IRQ_TMR2), base(IVT_BASE)) processOutputs(void) 
#endif
{
    unsigned char dummy;
    unsigned char anodes;
    unsigned char cathodes;
    
    if (PIR3bits.TMR2IF) {
        current_row++;
        current_row &= 0x3;
        
        // turn off the cathode drivers
        LATCbits.LATC2 = 1; // OE

        cathodes = ledMatrix[current_row];
        SPI1TXB = cathodes;

        // wait for data to be sent
        // This takes quite a bit of time but we have to ensure the cathodes have the
        // right data before turning on the anodes otherwise we don't get a clean display.
        while (SPI1CON2bits.BUSY)
            ;

        // turn the relevant anode driver on
        anodes = (uint8_t)(1 << (4+current_row));
        LATBbits.LATB4 = anodes & 0x10 ? 1 : 0;
        LATBbits.LATB5 = anodes & 0x20 ? 1 : 0;
        LATBbits.LATB6 = anodes & 0x40 ? 1 : 0;
        LATBbits.LATB7 = anodes & 0x80 ? 1 : 0;
        
        // turn the relevant cathode driver back on
        LATCbits.LATC2 = 0; //OE 

        PIR3bits.TMR2IF = 0;
    }
}



/**
 * Turn on an LED. No is 0-31.
 * @param no
 */
void setLed(uint8_t no) {
    ledMatrix[no/8] |= (1 << (no%8));
}

/**
 * Turn an LED off. No is 0-31
 */
void clearLed(uint8_t no) {
    ledMatrix[no/8] &= ~(1 << (no%8));
}

/**
 * Test if an LED is on.
 * @param no
 * @return 0 if OFF or non zero if ON
 */
uint8_t testLed(uint8_t no) {
    return ledMatrix[no/8] & (1 << (no%8));
}

