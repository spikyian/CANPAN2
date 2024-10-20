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
#include "event_teach.h"
#include "mns.h"
#include "canpan3Events.h"
#include "canpan3Outputs.h"

static uint8_t flashToggle;

void factoryResetGlobalEvents(void) {
    uint8_t i;

    // set up the default switch/button events
    for (i=1; i<= NUM_BUTTONS; i++) {
        // write 3 EVs for the buttons/switches produced events
        addEvent(nn.word, i, EV_TYPE, CANPAN_PRODUCED, TRUE);
        addEvent(nn.word, i, EV_SWITCHNO, i, TRUE);
        addEvent(nn.word, i, EV_SWITCHSV, SV_ON_OFF|SV_COE, TRUE);
        // write the EVs so that these default events also turn on an LED for testing
        addEvent(nn.word, i, EV_LEDFLAGS1, ((uint16_t)1<<(i-1))&0xFF, TRUE);
        addEvent(nn.word, i, EV_LEDFLAGS2, ((uint16_t)1<<(i-9))&0xFF, TRUE);
        addEvent(nn.word, i, EV_LEDFLAGS3, ((uint16_t)1<<(i-17))&0xFF, TRUE);
        addEvent(nn.word, i, EV_LEDFLAGS4, ((uint16_t)1<<(i-25))&0xFF, TRUE);
        addEvent(nn.word, i, EV_LEDPOLARITY1, 0, TRUE);
        addEvent(nn.word, i, EV_LEDPOLARITY2, 0, TRUE);
        addEvent(nn.word, i, EV_LEDPOLARITY3, 0, TRUE);
        addEvent(nn.word, i, EV_LEDPOLARITY4, 0, TRUE);
        addEvent(nn.word, i, EV_LEDMODE, LM_ONOFF, TRUE);
    }
}

void initEvents(void) {
    flashToggle = 0;
}

uint8_t APP_addEvent(uint16_t nodeNumber, uint16_t eventNumber, uint8_t evNum, uint8_t evVal, Boolean forceOwnNN) {
    return addEvent(nodeNumber, eventNumber, evNum, evVal, forceOwnNN);
}

/**
 * The CANPAN represents the event type in EV#1 however it also uses Bit 4 of EV#3 to control
 * self consumption of produced events. 
 * 
 * @param tableIndex
 * @return 
 */
uint8_t APP_isConsumedEvent(uint8_t tableIndex) {
    int16_t ev;
    
    ev = getEv(tableIndex, EV_TYPE);
    if (ev < 0) {
        // TODO If receive an event for a Toggle switch then update our outputState[]
        return 0;
    }
    if (ev == CANPAN_CONSUMED) {
        return 1;
    }
    ev = getEv(tableIndex, EV_SWITCHSV);
    if (ev < 0) {
        return 0;
    }
    return (ev & SV_COE);
}
/**
 * The CANPAN represents the event type in EV#1. 
 * 
 * @param tableIndex
 * @return 
 */
uint8_t APP_isProducededEvent(uint8_t tableIndex) {
    int16_t ev;
    
    ev = getEv(tableIndex, EV_TYPE);
    if (ev == CANPAN_PRODUCED) {
        return 1;
    }
    return 0;
}

/**
 * Update the ledStates array for all the LEDs impacted by the event according 
 * to the event's EVs.
 * 
 * @param tableIndex the index of the event data
 * @param m event message pointer
 * @return 
 */
Processed APP_processConsumedEvent(uint8_t tableIndex, Message *m) {
    uint8_t onOff;
    uint8_t ledMode;
    uint8_t ledNo;
    uint8_t flags;
    uint8_t polarity;
    
    onOff = m->opc & 1;
    if (getEVs(tableIndex)) {   
        // something went wrong
        return PROCESSED;
    }
    ledMode = evs[EV_LEDMODE];
    for (ledNo=0; ledNo<NUM_LEDS; ledNo++) {
        flags = evs[EV_LEDFLAGS1 + ledNo/8] & ((1 << ledNo)%8);
        if (flags) {
            // this LED is impacted
            polarity = evs[EV_LEDPOLARITY1 + ledNo/8]& ((1 << ledNo)%8);
            switch(ledMode) {
                case LM_ONOFF:
                    ledStates[ledNo] = polarity ? !onOff : onOff;
                    if (polarity) {
                        // inverted
                        if (onOff) {
                            clearLed(ledNo);
                            ledStates[ledNo] = CANPANLED_OFF;
                        } else {
                            setLed(ledNo);
                            ledStates[ledNo] = CANPANLED_ON;
                        }
                        
                    } else {
                        // normal
                        if (onOff) {
                            setLed(ledNo);
                            ledStates[ledNo] = CANPANLED_ON;
                        } else {
                            clearLed(ledNo);
                            ledStates[ledNo] = CANPANLED_OFF;
                        }
                    }
                    break;
                case LM_ONONLY:
                    if (onOff) {
                        if (polarity) {
                            clearLed(ledNo);
                            ledStates[ledNo] = CANPANLED_OFF;
                        } else {
                            setLed(ledNo);
                            ledStates[ledNo] = CANPANLED_ON;
                        }
                    }
                    break;
                case LM_OFFONLY:
                    if (!onOff) {
                        if (polarity) {
                            clearLed(ledNo);
                            ledStates[ledNo] = CANPANLED_OFF;
                        } else {
                            setLed(ledNo);
                            ledStates[ledNo] = CANPANLED_ON;
                        }
                    }
                    break;
                case LM_FLASH:
                    if (onOff) {
                        clearLed(ledNo);
                        if (polarity) {
                            ledStates[ledNo] = CANPANLED_ANTIFLASH;
                        } else {
                            ledStates[ledNo] = CANPANLED_FLASH;
                        }
                    } else {
                        clearLed(ledNo);
                        ledStates[ledNo] = CANPANLED_OFF;
                    }
                    break;
            }
        }
    }
    
    return PROCESSED;
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
                break;
            case CANPANLED_OFF:
                break;
        }
    }
    flashToggle = !flashToggle;
}

EventState APP_GetEventIndexState(uint8_t tableIndex) {
    uint8_t switchNo;
    
    // check this is a produced event
    if ( ! APP_isProducededEvent(tableIndex)) {
        return EVENT_UNKNOWN;
    }
    // get the switch number
    getEVs(tableIndex);
    switchNo = evs[EV_SWITCHNO];
    if (switchNo >= NUM_BUTTONS) {
        return EVENT_UNKNOWN;
    }
    // look at the state
    return outputState[switchNo] ? EVENT_ON : EVENT_OFF;
}