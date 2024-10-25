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
    TRISBbits.TRISB4 = 0;   // anode driver output
    TRISBbits.TRISB5 = 0;   // anode driver output
    
    LATBbits.LATB4 = 0;    // LED anode drivers off
    LATBbits.LATB5 = 0;
    LATCbits.LATC6 = 0;
    LATCbits.LATC7 = 0;
    
    // Cathode driver output enable
    TRISCbits.TRISC2 = 0;
    LATCbits.LATC2 = 0;     // disabled.
    
    // latch
    TRISCbits.TRISC4 = 0;
    LATCbits.LATC4 = 0;     // unlatch
    
    //Set up the MSSP to drive the switch matrix
    TRISCbits.TRISC3 = 0;   //clock
    LATCbits.LATC3 = 0;
    TRISCbits.TRISC5 = 0;   // data
    LATCbits.LATC5 = 0;
    
    SPI1CON0 = 0x03; // MSb first, host mode, Total bit count Mode=1, transmit only
    SPI1CON1 = 0x44; // clock edge, SSP=0 for active low and latches when it goes low
    SPI1CON2 = 0x02; // transmitter on, receiver off
        
    SPI1TCNTH=0;     // 1 byte
    SPI1TCNTL=1;     // 1 byte
    SPI1TWIDTH=0;   // 8 bits

    SPI1CLK = 0x00; // Clock from Fosc
    SPI1BAUD = 15;  // Fosc/32

    // set up PPS to the correct pins
    RC5PPS = 0x32; // SPI1SDO
    RC3PPS = 0x31; // SPI1SCK
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
    uint8_t i;
    uint8_t cathodes;
    
    if (PIR3bits.TMR2IF) {
        current_row++;
        current_row &= 0x3;
        
        // disable the cathode driver
        LATCbits.LATC2 = 1; // OE
        // also turn the anodes off
        LATBbits.LATB4 = 0;
        LATBbits.LATB5 = 0;
        LATCbits.LATC6 = 0;
        LATCbits.LATC7 = 0;

        cathodes = ledMatrix[current_row];
        SPI1TCNTH=0;     // 1 byte
        SPI1TCNTL=1;     // 1 byte
        SPI1TWIDTH=0;   // 8 bits
        
        SPI1TXB = cathodes; // do the write and send the data

        // wait for data to be sent and latched to form the anode outputs
        // This takes quite a few cycles but we have to ensure the cathodes have the
        // right data before turning on the anodes otherwise we don't get a clean display.
        //while (SPI1CON2bits.BUSY)
        //while (! SPI1INTFbits.SRMTIF)
        //while (SPI1INTFbits.TCZIF)
        while (! SPI1STATUSbits.TXBE)
            ;
        
        // It can take up to 365ns for the TLC5917 outputs to output correct data (LE to OUT)
        // This is 5 instruction cycles (5 * 62.5 ns)
        // following code before enabling the cathodes is more than 5 instructions

        // turn the relevant anode driver on
        switch (current_row) {
            case 0:
                LATBbits.LATB4 = 1;
                break;
            case 1:
                LATBbits.LATB5 = 1;
                break;
            case 2:
                LATCbits.LATC6 = 1;
                break;
            case 3:
                LATCbits.LATC7 = 1;
                break;
        }
        
        // enable the cathode driver
        LATCbits.LATC2 = 0; //OE 
        // clear the timer interrupt flag ready for next timer expiry
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

