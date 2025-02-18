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
#include "canpan3Leds.h"
#include "canpan3Inputs.h"

// forward declarations
void checkDefaultEvents(void);

uint8_t APP_isProducedEvent(uint8_t tableIndex);
uint8_t switch2Event[NUM_BUTTONS]; // Quick access from a switch number to an event

void factoryResetGlobalEvents(void) {
    uint8_t sw;

    // set up the default switch/button events
    checkDefaultEvents();
}

/***************************** copied from event_teach_simple.c ***************/
/*
 * Each row in the event table consists of:
 * Event + flags + ev[PARAM_NUM_EV_EVENT] i.e. a total of 5 + PARAM_NUM_EV_EVENT bytes 
 */

#define EVENTTABLE_WIDTH (sizeof(Event) + 1 + PARAM_NUM_EV_EVENT)
#define EVENTTABLE_OFFSET_NNH   0
#define EVENTTABLE_OFFSET_NNL   1
#define EVENTTABLE_OFFSET_ENH   2
#define EVENTTABLE_OFFSET_ENL   3
#define EVENTTABLE_OFFSET_FLAGS 4
#define EVENTTABLE_OFFSET_EVS   5
// The flags
#define EVENT_FLAG_DEFAULT      1

/** Errno for error number. */
extern uint8_t errno;
/******************************************************************************/

/**
 * Create and add a default event for the switch.
 * 
 * @param sw switch number 1..32
 * @return event table index
 */
uint8_t addDefaultEvent(uint8_t sw) {
    addEvent(nn.word, sw, EV_TYPE, CANPAN_PRODUCED, TRUE);
    addEvent(nn.word, sw, EV_SWITCHNO, sw, TRUE);
    addEvent(nn.word, sw, EV_SWITCHSV, SV_TOGGLE | SV_COE, TRUE);
    // write the EVs so that these default events also turn on an LED for testing
/*    addEvent(nn.word, sw, EV_LEDFLAGS1, ((uint16_t)1<<(sw-1))&0xFF, TRUE);
    addEvent(nn.word, sw, EV_LEDFLAGS2, ((uint16_t)1<<(sw-9))&0xFF, TRUE);
    addEvent(nn.word, sw, EV_LEDFLAGS3, ((uint16_t)1<<(sw-17))&0xFF, TRUE);
    addEvent(nn.word, sw, EV_LEDFLAGS4, ((uint16_t)1<<(sw-25))&0xFF, TRUE); */
    // The following settings to 0 are probably not required as 0 should be the default.
    addEvent(nn.word, sw, EV_LEDFLAGS1, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDFLAGS2, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDFLAGS3, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDFLAGS4, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDPOLARITY1, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDPOLARITY2, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDPOLARITY3, 0, TRUE);
    addEvent(nn.word, sw, EV_LEDPOLARITY4, 0, TRUE);
    return addEvent(nn.word, sw, EV_LEDMODE, LM_ONOFF, TRUE);
}

/**
 * Check that each switch has an event and create one if not present.
 * Also update the quick access lookup table.
 */
void checkDefaultEvents(void) {
    uint8_t sw;
    int16_t swNo;
    uint8_t i;
    // zero out the lookup first
    
    for (sw=0; sw < NUM_BUTTONS; sw++) {
        switch2Event[sw] = NO_INDEX;
    }
    // Add in the events
    for (i=0; i<NUM_EVENTS; i++) {
        swNo = getEv(i, EV_SWITCHNO);
        if ((swNo >0) && ( swNo <= NUM_BUTTONS)) {
            switch2Event[swNo-1] = i;
        }
    }
    // Now create any missing default events
    for (sw=1; sw <= NUM_BUTTONS; sw++) {
        if (switch2Event[sw-1] == NO_INDEX) {
            switch2Event[sw-1] = addDefaultEvent(sw);
        }
    }
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
        // error
        return 0;
    }

    if ((ev == CANPAN_SOD)||(ev == CANPAN_SELF_SOD)) {    // SoD consumed event
        return 1;
    }
    ev = getEv(tableIndex, EV_LEDFLAGS1);
    if (ev) return 1;
    ev = getEv(tableIndex, EV_LEDFLAGS2);
    if (ev) return 1;
    ev = getEv(tableIndex, EV_LEDFLAGS3);
    if (ev) return 1;
    ev = getEv(tableIndex, EV_LEDFLAGS4);
    return ev != 0;
}

/**
 * The CANPAN represents the event type in EV#1. 
 * 
 * @param tableIndex
 * @return 
 */
uint8_t APP_isProducedEvent(uint8_t tableIndex) {
    int16_t ev;
    
    ev = getEv(tableIndex, EV_SWITCHNO);
    if ((ev > 0) && (ev <= NUM_BUTTONS)) {
        return 1;
    }
    return 0;
}

/**
 * Special handling when we receive a switch produced event for a toggle switch.
 * We update the internal toggle state to match that of the event.
 * 
 * @param m
 */
Processed APP_preProcessMessage(Message * m) {
    uint8_t tableIndex;
    uint16_t enn;
    uint8_t switchNo;
    uint8_t ev;

    if (mode_flags & FLAG_MODE_LEARN) {
        /* Now for add/delete update the switch2Event table */
        switch (m->opc) {
            case OPC_NNCLR:
            case OPC_EVULN:
            case OPC_EVLRN:
            case OPC_EVLRNI:
                /* Opcodes which add/delete events */
                errno = GRSP_OK;
                eventTeachService.processMessage(m);
                checkDefaultEvents();
                return PROCESSED;
            default:
                break;
        }
    }
    
    /* Now check for incoming events which match a toggle switch event. */
    if (m->len < 5) return NOT_PROCESSED;  
    enn = ((uint16_t)m->bytes[0])*256+m->bytes[1];
    switch (m->opc) {
        case OPC_ASON:
#ifdef HANDLE_DATA_EVENTS
        case OPC_ASON1:
        case OPC_ASON2:
        case OPC_ASON3:
#endif
		enn = 0;
		// fall through
        case OPC_ACON:
#ifdef HANDLE_DATA_EVENTS
        case OPC_ACON1:
        case OPC_ACON2:
        case OPC_ACON3:
#endif
            break;
        case OPC_ASOF:
#ifdef HANDLE_DATA_EVENTS
        case OPC_ASOF1:
        case OPC_ASOF2:
        case OPC_ASOF3:
#endif
		enn = 0;
		// fall through
        case OPC_ACOF:
#ifdef HANDLE_DATA_EVENTS
        case OPC_ACOF1:
        case OPC_ACOF2:
        case OPC_ACOF3:
#endif
            break;
        default:
            return NOT_PROCESSED;
    }
    
    // events only here
    tableIndex = findEvent(enn, ((uint16_t)m->bytes[2])*256+m->bytes[3]);
    if (tableIndex == NO_INDEX) return NOT_PROCESSED;
    if (APP_isProducedEvent(tableIndex)) { // can we produce this event?
        // If receive an event for a Toggle switch then update our outputState[]
        ev = (uint8_t)getEv(tableIndex, EV_SWITCHSV);
        if (ev & SV_TOGGLE) {
            switchNo = (uint8_t)getEv(tableIndex, EV_SWITCHNO) - 1;
            if (switchNo < NUM_BUTTONS) {
                outputState[switchNo] = !(m->opc & 1);  // on or off
            }
            return NOT_PROCESSED;   // Not processed as we want service to handle the event
        }
    }
    return NOT_PROCESSED;
}


uint8_t APP_addEvent(uint16_t nodeNumber, uint16_t eventNumber, uint8_t evNum, uint8_t evVal, Boolean forceOwnNN) {
    uint8_t tableIndex;
    uint8_t oti;
    uint8_t switchNo;
    uint8_t prevSwitchNo;
    uint8_t leds;
    
    if (evNum == EV_SWITCHNO) {
        switchNo = evVal;
        tableIndex = findEvent(nodeNumber, eventNumber);
        if (tableIndex != NO_INDEX) {
            // event found
            getEVs(tableIndex);
            prevSwitchNo = evs[EV_SWITCHNO];
            if (prevSwitchNo > NUM_BUTTONS) {
                prevSwitchNo = 0;
            }
            // Any LEDs associated with this event?
            leds = evs[EV_LEDFLAGS1] | evs[EV_LEDFLAGS2] | evs[EV_LEDFLAGS3] | evs[EV_LEDFLAGS4];
        }
        /*
         * Processing of switch events follows the following table
         * 
        	EV2		                    EV1					
        Row	New	    Old	                New	Old	EventId match	Default	LEDs	Changes
        1	0	    0	                nc		Match		            Yes	    No change
        2	0	    0	                nc		Match		            No	    Invalid event ? remove
        3	0	    -	                0		No match		        -	    Create new event
        4	0	    Valid	            nc		Match	        Yes	    Yes	    Error
        5	0	    Valid	            nc		Match	        No	    Yes     EV2=0 & create new default event for old EV2
        6	0	    Valid	            nc		Match	        Yes    	No	    Error
        7	0	    Valid	            nc	0	Match	        No	    No	    replace this event with default event for old EV2
        8	0	    Valid	            nc	SoD	Match	        No    	No	    Keep this event for SoD and create new default event for EV2
        9	0	    -	                -	-	No match		        -	    Create new event
        10	Valid	0	                nc		Match	    	        Yes	    EV2=new, switch2Event[new]?EV2=0. 
        11	Valid	0	                nc  0	Match	    	        No	    Error Invalid request
        12	Valid	0	                nc	SoD	Match	    	        No	    Error Invalid request
        13	Valid	-	                -	-	No match		        -	    New event, EV2=new, switch2Event[new]?EV2=0. 
        14	Valid	Valid and match    	nc		Match		            Yes     No change
        15	Valid	Valid and match	    nc		Match		            No	    No change
        16	Valid	Valid but no match	nc		Match	        Yes	    Yes     Error
        17	Valid	Valid but no match	nc		Match	        No	    Yes	    EV2=new, create default EV2=old, switch2Event[old]?EV2=created. 
        18	Valid	Valid but no match	nc		Match	        Yes    	No	    Error
        19	Valid	Valid but no match	nc		Match	        No	    No	    EV2=new, create default EV2=old
         * 
         */
        if ((switchNo > 0) && (switchNo <= NUM_BUTTONS)) {   
            // valid new switch, ROWS 10~19
            // find any previous event
            if (tableIndex != NO_INDEX) {
                if (prevSwitchNo == 0) {
                    if (leds) {
                        // ROW 10
                        oti = switch2Event[switchNo-1];
                        if (oti != NO_INDEX) {
                            writeEv(oti, EV_SWITCHNO, 0);
                        } else {
                            // should never happen
                        }
                        // continue to process normally now
                    } else {
                        // ROW 11,12
                        // shouldn't get here as this would have been an invalid event
                        // continue to fix
                    }
                } else {
                    if (switchNo == prevSwitchNo) {
                        // ROW14, ROW15
                        // No change to EV2
                        // do nothing
                        // Send a WRACK - difference from CBUS
                        return PROCESSED;
                    } else {
                        // ROW 16~19
                        // Here we are changing the switch associated with this event.
                        // Test if this is a default event and don't allow if it is
                        if (readNVM(EVENT_TABLE_NVM_TYPE, EVENT_TABLE_ADDRESS + EVENTTABLE_WIDTH*tableIndex+EVENTTABLE_OFFSET_FLAGS) && EVENT_FLAG_DEFAULT) {
                            // ROW 16,18
                            errno = CMDERR_INV_EV_VALUE;
                            return PROCESSED;
                        }
                        // ROW 17,19
                        // Now we can just create a new default event for the prevSwitchEvent
                        // and then continue to allow this EV2 to be written for the event.
                    }
                }
            } else {
                // ROW 13
                oti = switch2Event[switchNo-1];
                if (oti != NO_INDEX) {
                    writeEv(oti, EV_SWITCHNO, 0);
                } else {
                    // should never happen
                }
                // continue to process normally now
            }
        } else {
            // invalid new switch value specified, ROWS 1~9
            // force switchNo to zero
            switchNo = 0;
            evVal = 0;

            if (tableIndex != NO_INDEX) {
                // matches an existing event
                if (prevSwitchNo == 0) {
                    if (leds) {
                        // ROW 1
                        // do nothing
                        return PROCESSED;
                    } else {
                        // ROW 2
                        // this is an invalid event with no switches and no LEDs
                        // remove it
                        writeNVM(EVENT_TABLE_NVM_TYPE, EVENT_TABLE_ADDRESS + EVENTTABLE_WIDTH*tableIndex+EVENTTABLE_OFFSET_ENL, 0);
                        writeNVM(EVENT_TABLE_NVM_TYPE, EVENT_TABLE_ADDRESS + EVENTTABLE_WIDTH*tableIndex+EVENTTABLE_OFFSET_ENH, 0);
                        return PROCESSED;
                    }
                } else {
                    // existing event had a valid switch
                    // Test if this is a default event and don't allow if it is
                    if (readNVM(EVENT_TABLE_NVM_TYPE, EVENT_TABLE_ADDRESS + EVENTTABLE_WIDTH*tableIndex+EVENTTABLE_OFFSET_FLAGS) && EVENT_FLAG_DEFAULT) {
                        // ROW 4,6
                        errno = CMDERR_INV_EV_VALUE;
                        return PROCESSED;
                    }
                    if (leds) {
                        // ROW 5
                        // let standard processing write EV2=0 and create a new default event
                    } else {
                        // ROW 7~8
                        
                        if ((evs[EV_TYPE] == CANPAN_SELF_SOD) || (evs[EV_TYPE] == CANPAN_SOD)) {
                            // ROW 8
                            // let standard processing write EV2=0 and create a new default event
                        } else {
                            // ROW 7
                            // delete this event and let standard processing write EV2=0 and create a new default event
                            writeNVM(EVENT_TABLE_NVM_TYPE, EVENT_TABLE_ADDRESS + EVENTTABLE_WIDTH*tableIndex+EVENTTABLE_OFFSET_ENL, 0);
                            writeNVM(EVENT_TABLE_NVM_TYPE, EVENT_TABLE_ADDRESS + EVENTTABLE_WIDTH*tableIndex+EVENTTABLE_OFFSET_ENH, 0);
                        }
                    }
                }
            } else {
                // doesn't match an existing event
                // ROW 3, ROW 9
                // Let normal handling create this event, not associated with a switch
            }
        }
    }
    return addEvent(nodeNumber, eventNumber, evNum, evVal, forceOwnNN);
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
    
    onOff = !(m->opc & 1);
    if (getEVs(tableIndex)) {   
        // something went wrong
        return PROCESSED;
    }
    if (onOff && ((evs[EV_TYPE] == CANPAN_SOD)||(evs[EV_TYPE] == CANPAN_SELF_SOD))) {
        doSoD();
    }
    // using the EVs and the event on/off state we work out the new LED state
    ledMode = evs[EV_LEDMODE];
    for (ledNo=0; ledNo<NUM_LEDS; ledNo++) {
        flags = evs[EV_LEDFLAGS1 + ledNo/8] & (1 << (ledNo%8));
        if (flags) {
            // this LED is impacted
            polarity = evs[EV_LEDPOLARITY1 + ledNo/8]& (1 << (ledNo%8));
            switch(ledMode) {
                case LM_ONOFF:
                    if (polarity) {
                        // inverted
                        if (onOff) {
                            setLedState(ledNo, CANPANLED_OFF);
                        } else {
                            setLedState(ledNo, CANPANLED_ON);
                        }
                        
                    } else {
                        // normal
                        if (onOff) {
                            setLedState(ledNo, CANPANLED_ON);
                        } else {
                            setLedState(ledNo, CANPANLED_OFF);
                        }
                    }
                    break;
                case LM_ONONLY:
                    if (onOff) {
                        if (polarity) {
                            setLedState(ledNo, CANPANLED_OFF);
                        } else {
                            setLedState(ledNo, CANPANLED_ON);
                        }
                    }
                    break;
                case LM_OFFONLY:
                    if (!onOff) {
                        if (polarity) {
                            setLedState(ledNo, CANPANLED_ON);
                        } else {
                            setLedState(ledNo, CANPANLED_OFF);
                        }
                    }
                    break;
                case LM_FLASH:
                    if (onOff) {
                        if (polarity) {
                            setLedState(ledNo, CANPANLED_ANTIFLASH);
                        } else {
                            setLedState(ledNo, CANPANLED_FLASH);
                        }
                    } else {
                        setLedState(ledNo, CANPANLED_OFF);
                    }
                    break;
            }
        }
    }
    return PROCESSED;
}


/**
 * Gets the current event state of a produced event by table index.
 * @param tableIndex
 * @return 
 */
EventState APP_GetEventIndexState(uint8_t tableIndex) {
    uint8_t switchNo;
    
    // check this is a produced event
    if ( ! APP_isProducedEvent(tableIndex)) {
        return EVENT_UNKNOWN;
    }
    // get the switch number
    getEVs(tableIndex);
    switchNo = evs[EV_SWITCHNO];
    if ((switchNo < 1) || (switchNo > NUM_BUTTONS)) {
        return EVENT_UNKNOWN;
    }
    // look at the state
    return outputState[switchNo-1] ? EVENT_ON : EVENT_OFF;
}