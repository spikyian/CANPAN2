/* TODOs

4) Save event state when EVs are edited. I'm still unsure about this so I need to 
investigate further.

5) LED flicker when a toggle switch is operated.
I can confirm this is a bug. I think this is caused by an uninterruptible delay 
caused by writing to EEPROM. If the switch processing takes place at different parts 
of the LED refresh cycle then the LED will either flash brightly or flicker more dimly. 
Still need to have a closer look on what can be done to resolve this. 
It may become a feature :)

*/

#include <xc.h>
#include "module.h"
#include "vlcb.h"
// the services
#include "mns.h"
#include "nv.h"
#include "can.h"
#include "boot.h"
#include "event_teach.h"
#include "event_consumer_simple.h"
#include "event_producer.h"
#include "event_acknowledge.h"
#include "event_coe.h"
// others
#include "ticktime.h"
#include "timedResponse.h"
#include "devincs.h"
#include <stddef.h>
#include "statusLeds.h"
#include "nvm.h"
#include "timedResponse.h"
// module specific
#include "canpan3Nv.h"
#include "canpan3Inputs.h"
#include "canpan3Events.h"
#include "canpan3Outputs.h"
#include "canpan3Leds.h"
#include "EEPROMbuffer.h"

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
 *	The Main CANPAN module
 *
 * @author Ian Hogg 
 * @date August 2024
 * 
 */ 
/**
 * @copyright Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
 */ 




/**************************************************************************
 * Application code packed with the bootloader must be compiled with options:
 * XC8 linker options -> Additional options --CODEOFFSET=0x800 
 * This generates an error
 * ::: warning: (2044) unrecognized option "--CODEOFFSET=0x800"
 * but this can be ignored as the option works
 * 
 * Then the Application project must be made dependent on the Bootloader 
 * project by adding the Bootloader to project properties->Conf:->Loading
 ***************************************************************************/

/*
 * File:   main.c
 * Author: Ian Hogg
 * 
 * This is the main for the CANPAN3 module.
 * Based on EV and NV settings of CANPAN_4c_beta104
 */

// TODOs
// * Debounce inputs - if needed
//


// forward declarations
void __init(void);
uint8_t checkCBUS( void);
void ISRHigh(void);
void factoryResetGlobalEvents(void);
extern void initLeds(void);
extern void clearAllEvents(void);
extern uint8_t addTestEvent(uint8_t sw);
#if defined(_18F66K80_FAMILY_)
extern void inputIsr(void);
extern void outputIsr(void);
#endif

static TickValue   startTime;
static uint8_t     started;
static TickValue   lastInputScanTime;
static TickValue   flashTime;
static TickValue   outputPollTime;
static TickValue   eepromWriterTime;

const Service * const services[] = {
    &canService,
    &mnsService,
    &nvService,
    &bootService,
    &eventTeachService,
    &eventConsumerService,
    &eventProducerService,
    &eventCoeService
};


/**
 * Called at first run to initialise all the non volatile memory. 
 * Also called if the PB hold down special sequence at power up is done.
 * Also called as a result of a NNRSM request.
 */
void APP_factoryReset(void) {
    uint8_t sw;
    
    factoryResetGlobalEvents();

    flushFlashBlock();
    
    // Write the EEPROM for the toggle switch inputs
    for (sw=0; sw < NUM_BUTTONS; sw++) {
        writeNVM(EEPROM_NVM_TYPE, EE_ADDR_SWITCHES+sw, 0);
    }
}

/**
 * Called if the PB is held down during power up.
 * Normally would perform any test functionality to help a builder check the hardware.
 * 
 * Create an event for every switch which also turns on the respective LED.
 * WARNING: Will remove any user provisioned events
 */
void APP_testMode(void) {
    uint8_t sw;
    
    clearAllEvents();
    
    for (sw=0; sw<NUM_BUTTONS; sw++) {
        addTestEvent(sw+1);
    }
}

/**
 * Called upon power up.
 */
void setup(void) {
#if defined(_18FXXQ83_FAMILY_)
    uint8_t pu;
#endif
    uint8_t nv;
    
    // use CAN as the module's transport
    transport = &canTransport;

    /**
     * The order of initialisation is important.
     */
#if defined(_18F66K80_FAMILY_)
    INTCON2bits.RBPU = 0;
    // default to all digital IO
    ANCON0 = 0x00;
    ANCON1 = 0x00;
#endif
#if defined(_18FXXQ83_FAMILY_)
    WPUA = 0b00001000;  // ensure the pushbutton pullup is still enabled
    WPUB = 0;
    WPUC = 0;
    ANSELA = 0x00;
    ANSELB = 0x00;
    ANSELC = 0x00;
#endif
    
    initEEPROMwriter();
    initOutputs();
    initLeds();
    initInputs();
    initEvents();
    
    // Lock the PPS
/*    PPSLOCK = 0x55; //Required sequence
    PPSLOCK = 0xAA; //Required sequence
    PPSLOCKbits.PPSLOCKED = 1; //Set PPSLOCKED bit
*/
    // enable interrupts, all init now done
    ei(); 

    startTime.val = tickGet();
    lastInputScanTime.val = startTime.val;
    flashTime.val = startTime.val;
    outputPollTime.val = startTime.val;
    eepromWriterTime.val = startTime.val;

    started = FALSE;
    canpanScanReady = 0;
    
    nv = (uint8_t)getNV(NV_STARTUP);
}

/**
 * The loop code call repeatedly from VLCB.
 */
void loop(void) {
    uint8_t tableIndex;
    
    // Startup delay for CBUS about 2 seconds to let other modules get powered up - ISR will be running so incoming packets processed
    if (started == FALSE) {
        if (tickTimeSince(startTime) >  (TWO_SECOND+getNV(NV_STARTUP_EVENT_DELAY)*ONE_SECOND)) {
            started = TRUE;
            tableIndex = switch2Event[SOD_PSEUDO_SWITCH-1];
            if (tableIndex != NO_INDEX) canpanSendProducedEvent(tableIndex, TRUE);
        }
    } else {
        if (tickTimeSince(lastInputScanTime) > 2*ONE_MILI_SECOND) {
            inputScan();    // Strobe inputs for changes
            lastInputScanTime.val = tickGet();
        }
    }
    if (tickTimeSince(flashTime)/1000 > getNV(NV_FLASHRATE)) {
        doFlash();    // update flashing LEDs
        flashTime.val = tickGet();
    }
    // poll the LED display quickly.
    if (tickTimeSince(outputPollTime) > HUNDRED_MICRO_SECOND) {
        pollOutputs();
        outputPollTime.val = tickGet();
    }
    // Check to see if there are any EEPROM writes waiting to be done. 
    // A write takes max 11 ms but CPU isn't blocked unless there is already 
    // a write in progress. 
    if (tickTimeSince(eepromWriterTime) > ONE_MILI_SECOND) {
        pollEEPROMwriter();
    }
}

// Application functions required by MERGLCB library


/**
 * Check to see if now is a good time to start a flash write.
 * It is a bad time if we are currently doing a servo pulse.
 * 
 * If a servo pulse timer is currently running then the NVM routine will keep 
 * calling this until the timer expires.
 * 
 * @return GOOD_TIME if OK else BAD_TIME
 */
ValidTime APP_isSuitableTimeToWriteFlash(void){
    return GOOD_TIME;
}

/**
 * This application doesn't need to process any messages in a special way.
 */
Processed APP_postProcessMessage(Message * m) {
    return NOT_PROCESSED;
}

/**
 * This is needed by the library to get the current event state. 
 *
EventState APP_GetEventState(Happening h) {
    uint8_t flags;
    uint8_t happeningIndex;
    Boolean disable_off;
    
    
    // The TRIGGER_INVERTED has already been taken into account when saved in outputState. No need to check again
    return outputState[io]?EVENT_ON:EVENT_OFF;

}*/


#if defined(_18F66K80_FAMILY_)

// APP Interrupt service routines
void APP_lowIsr(void) {
    outputIsr();
}

// Interrupt service routines
void APP_highIsr(void) {

}
#endif
