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
#include "canpan3Leds.h"
#include "canpan3Outputs.h"
#include "canpan3Nv.h"
#include "nv.h"

//forward references
void setLedStateNoSave(uint8_t ledNo, enum canpan3LedState state);

static enum canpan3LedState ledStates[NUM_LEDS];
static uint8_t flashToggle;
static uint8_t startupNv;

/**
 * Initialise the LEDs.
 */
void initLeds(void) {
    uint8_t ledNo;
    
    startupNv = (uint8_t)getNV(NV_STARTUP);
    
    for (ledNo=0; ledNo<NUM_LEDS; ledNo++) {
        if (startupNv & NV_STARTUP_RESTORELEDS) {
            enum canpan3LedState state = (uint8_t)readNVM(EEPROM_NVM_TYPE, EE_ADDR_LEDS+ledNo);
            setLedStateNoSave(ledNo, state);
        } else {
            ledStates[ledNo] = CANPANLED_OFF;
        }
    }
    flashToggle = 0;
}

/**
 * Set the specified LED to the given state.
 * @param led
 * @param state
 */
void setLedStateNoSave(uint8_t ledNo, enum canpan3LedState state) {
    ledStates[ledNo] = state;
    switch (ledStates[ledNo]) {
        case CANPANLED_ON:
            setLed(ledNo);
            break;
        case CANPANLED_OFF:
            clearLed(ledNo);
            break;
        case CANPANLED_FLASH:
        case CANPANLED_ANTIFLASH:
            // flashing states get dealt with by the doFlash function
            break;
    }
    
}
/**
 * Set the specified LED to the given state and save the vale in EEPROM.
 * @param led
 * @param state
 */
void setLedState(uint8_t ledNo, enum canpan3LedState state) {
    setLedStateNoSave(ledNo, state);
    if (startupNv & NV_STARTUP_RESTORELEDS) {
        EEPROM_WriteNoVerify(EE_ADDR_LEDS+ledNo, (uint8_t)state);
    }
}

/**
 * Call regularly at required flash rate.
 */
void doFlash(void) {
    uint8_t ledNo;
    
    for (ledNo=0; ledNo<NUM_LEDS; ledNo++) {
        switch (ledStates[ledNo]) {
            case CANPANLED_FLASH:
                if (flashToggle) {
                    setLed(ledNo);
                } else {
                    clearLed(ledNo);
                }
                break;
            case CANPANLED_ANTIFLASH:
                if (flashToggle) {
                    clearLed(ledNo);
                } else {
                    setLed(ledNo);
                }
                break;
            case CANPANLED_ON:
            case CANPANLED_OFF:
                // these have already been handled in the setter above
                break;
        }
    }
    flashToggle = !flashToggle;
}
