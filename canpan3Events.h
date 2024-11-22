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

extern void initEvents(void);
extern void doFlash(void);
extern uint8_t APP_isProducedEvent(uint8_t tableIndex);

// EV1 value
#define CANPAN_CONSUMED 0
#define CANPAN_PRODUCED 1
#define CANPAN_SOD      2
#define CANPAN_SELF_SOD 3
// Switch inputs EVs
#define EV_TYPE         0
#define EV_SWITCHNO     1
#define EV_SWITCHSV     2
#define EV_UNUSED       3
#define EV_LEDFLAGS1    4
#define EV_LEDFLAGS2    5
#define EV_LEDFLAGS3    6
#define EV_LEDFLAGS4    7
#define EV_LEDPOLARITY1 8
#define EV_LEDPOLARITY2 9
#define EV_LEDPOLARITY3 10
#define EV_LEDPOLARITY4 11
#define EV_LEDMODE      12

// EV_SWITCHSV (switch mode) values
#define SV_NONE     0
#define SV_ON_OFF   1
#define SV_OFF_ON   3
#define SV_ON_ONLY  4
#define SV_OFF_ONLY 6
#define SV_TOGGLE   8
// individual bits
#define SV_POLARITY 0b00000010
#define SV_ONLY     0b00000100 
#define SV_COE      0b00010000
#define SV_SHORT    0b00100000


// EV_LEDMODE values
#define LM_ONOFF    0xFF
#define LM_ONONLY   0xFE
#define LM_OFFONLY  0xFD
#define LM_FLASH    0xF8