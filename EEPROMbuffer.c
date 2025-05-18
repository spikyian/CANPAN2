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
 * @date May 2025
 * 
 */ 

#import <xc.h>
#import "nvm.h"
#import "module.h"
/**
 * Maintains a list of EEPROM changes required and will submit these to the NVM 
 * peripheral so that the CPU does not need to wait. A wait would occurr if 
 * overlapping writes to the NVM are requested so this code waits until the NVM
 * is available, buffering requets. 
 */

static uint8_t writeNeeded[NUMBER_EEPROM];
static uint8_t eeValue[NUMBER_EEPROM];
static uint8_t currentMemory;

/**
 * Initialise the EEPROM writer.
 */
void initEEPROMwriter(void) {
    for(currentMemory = 0; currentMemory < NUMBER_EEPROM; currentMemory++) {
        writeNeeded[currentMemory] = 0;
        eeValue[currentMemory] = (uint8_t)readNVM(EEPROM_NVM_TYPE, EEPROM_BASE_ADDRESS+currentMemory);
    }
    currentMemory = 0;
}

/**
 * Request that EEPROM is written with the specified value to the supplied 
 * address. This does not actually perform a write but instead buffers the 
 * request and flags that the address needs to be written at a suitable time 
 * later.
 * 
 * @param address offset address in EEPROM
 * @param value the value to be written
 */
void writeEEvalue(uint8_t address, uint8_t value) {
    if (eeValue[address] != value) {
        eeValue[address] = value;
        writeNeeded[address] = 1;
    }
}

/**
 * Read the contents of the EE value from RAM.
 * @param address
 * @return 
 */
uint8_t readEEvalue(uint8_t address) {
    return eeValue[address];
}

/**
 * Waits for the NVM peripheral to be available then looks for the next 
 * EEPROM byte to be written and writes it to EEPROM.
 */
void pollEEPROMwriter(void) {
    uint8_t i;
    
    // Is the NVM available to be used?
    if (NVMCON0 == 0) {
        // write the next
        for (i=0; i < NUMBER_EEPROM; i++) {
            currentMemory ++;
            if (currentMemory >= NUMBER_EEPROM) {
                currentMemory = 0;
            }
            if (writeNeeded[currentMemory] == 1) {
                // start the write to EEPROM
                EEPROM_WriteNoVerify(EEPROM_BASE_ADDRESS + currentMemory, eeValue[currentMemory]);
                return;
            }
        }
        // No writes needed
    }
}