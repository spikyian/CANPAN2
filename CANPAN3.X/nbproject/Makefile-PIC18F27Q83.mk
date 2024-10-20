#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-PIC18F27Q83.mk)" "nbproject/Makefile-local-PIC18F27Q83.mk"
include nbproject/Makefile-local-PIC18F27Q83.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=PIC18F27Q83
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../main.c ../canpan3Events.c ../canpan3Inputs.c ../canpan3Nv.c ../canpan3Outputs.c ../../VLCBlib_PIC/boot.c ../../VLCBlib_PIC/can18_can_2.c ../../VLCBlib_PIC/event_acknowledge.c ../../VLCBlib_PIC/event_coe.c ../../VLCBlib_PIC/event_consumer_simple.c ../../VLCBlib_PIC/event_teach_simple.c ../../VLCBlib_PIC/messageQueue.c ../../VLCBlib_PIC/mns.c ../../VLCBlib_PIC/nv.c ../../VLCBlib_PIC/nvm.c ../../VLCBlib_PIC/statusLeds2.c ../../VLCBlib_PIC/ticktime.c ../../VLCBlib_PIC/timedResponse.c ../../VLCBlib_PIC/vlcb.c ../../VLCBlib_PIC/event_producer_simple.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1472/main.p1 ${OBJECTDIR}/_ext/1472/canpan3Events.p1 ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1 ${OBJECTDIR}/_ext/1472/canpan3Nv.p1 ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1 ${OBJECTDIR}/_ext/1954642981/boot.p1 ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1 ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1 ${OBJECTDIR}/_ext/1954642981/event_coe.p1 ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1 ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1 ${OBJECTDIR}/_ext/1954642981/messageQueue.p1 ${OBJECTDIR}/_ext/1954642981/mns.p1 ${OBJECTDIR}/_ext/1954642981/nv.p1 ${OBJECTDIR}/_ext/1954642981/nvm.p1 ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1 ${OBJECTDIR}/_ext/1954642981/ticktime.p1 ${OBJECTDIR}/_ext/1954642981/timedResponse.p1 ${OBJECTDIR}/_ext/1954642981/vlcb.p1 ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1472/main.p1.d ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d ${OBJECTDIR}/_ext/1954642981/boot.p1.d ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d ${OBJECTDIR}/_ext/1954642981/mns.p1.d ${OBJECTDIR}/_ext/1954642981/nv.p1.d ${OBJECTDIR}/_ext/1954642981/nvm.p1.d ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1472/main.p1 ${OBJECTDIR}/_ext/1472/canpan3Events.p1 ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1 ${OBJECTDIR}/_ext/1472/canpan3Nv.p1 ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1 ${OBJECTDIR}/_ext/1954642981/boot.p1 ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1 ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1 ${OBJECTDIR}/_ext/1954642981/event_coe.p1 ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1 ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1 ${OBJECTDIR}/_ext/1954642981/messageQueue.p1 ${OBJECTDIR}/_ext/1954642981/mns.p1 ${OBJECTDIR}/_ext/1954642981/nv.p1 ${OBJECTDIR}/_ext/1954642981/nvm.p1 ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1 ${OBJECTDIR}/_ext/1954642981/ticktime.p1 ${OBJECTDIR}/_ext/1954642981/timedResponse.p1 ${OBJECTDIR}/_ext/1954642981/vlcb.p1 ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1

# Source Files
SOURCEFILES=../main.c ../canpan3Events.c ../canpan3Inputs.c ../canpan3Nv.c ../canpan3Outputs.c ../../VLCBlib_PIC/boot.c ../../VLCBlib_PIC/can18_can_2.c ../../VLCBlib_PIC/event_acknowledge.c ../../VLCBlib_PIC/event_coe.c ../../VLCBlib_PIC/event_consumer_simple.c ../../VLCBlib_PIC/event_teach_simple.c ../../VLCBlib_PIC/messageQueue.c ../../VLCBlib_PIC/mns.c ../../VLCBlib_PIC/nv.c ../../VLCBlib_PIC/nvm.c ../../VLCBlib_PIC/statusLeds2.c ../../VLCBlib_PIC/ticktime.c ../../VLCBlib_PIC/timedResponse.c ../../VLCBlib_PIC/vlcb.c ../../VLCBlib_PIC/event_producer_simple.c



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-PIC18F27Q83.mk ${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=18F27Q83
# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1472/main.p1: ../main.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/main.p1 ../main.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/main.d ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Events.p1: ../canpan3Events.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Events.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Events.p1 ../canpan3Events.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Events.d ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Inputs.p1: ../canpan3Inputs.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1 ../canpan3Inputs.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Inputs.d ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Nv.p1: ../canpan3Nv.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Nv.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Nv.p1 ../canpan3Nv.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Nv.d ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Outputs.p1: ../canpan3Outputs.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1 ../canpan3Outputs.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Outputs.d ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/boot.p1: ../../VLCBlib_PIC/boot.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/boot.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/boot.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/boot.p1 ../../VLCBlib_PIC/boot.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/boot.d ${OBJECTDIR}/_ext/1954642981/boot.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/boot.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/can18_can_2.p1: ../../VLCBlib_PIC/can18_can_2.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1 ../../VLCBlib_PIC/can18_can_2.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/can18_can_2.d ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1: ../../VLCBlib_PIC/event_acknowledge.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1 ../../VLCBlib_PIC/event_acknowledge.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.d ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_coe.p1: ../../VLCBlib_PIC/event_coe.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_coe.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_coe.p1 ../../VLCBlib_PIC/event_coe.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_coe.d ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1: ../../VLCBlib_PIC/event_consumer_simple.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1 ../../VLCBlib_PIC/event_consumer_simple.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.d ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1: ../../VLCBlib_PIC/event_teach_simple.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1 ../../VLCBlib_PIC/event_teach_simple.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.d ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/messageQueue.p1: ../../VLCBlib_PIC/messageQueue.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/messageQueue.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/messageQueue.p1 ../../VLCBlib_PIC/messageQueue.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/messageQueue.d ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/mns.p1: ../../VLCBlib_PIC/mns.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/mns.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/mns.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/mns.p1 ../../VLCBlib_PIC/mns.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/mns.d ${OBJECTDIR}/_ext/1954642981/mns.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/mns.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/nv.p1: ../../VLCBlib_PIC/nv.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nv.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nv.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/nv.p1 ../../VLCBlib_PIC/nv.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/nv.d ${OBJECTDIR}/_ext/1954642981/nv.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/nv.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/nvm.p1: ../../VLCBlib_PIC/nvm.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nvm.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nvm.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/nvm.p1 ../../VLCBlib_PIC/nvm.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/nvm.d ${OBJECTDIR}/_ext/1954642981/nvm.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/nvm.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/statusLeds2.p1: ../../VLCBlib_PIC/statusLeds2.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1 ../../VLCBlib_PIC/statusLeds2.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/statusLeds2.d ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/ticktime.p1: ../../VLCBlib_PIC/ticktime.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/ticktime.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/ticktime.p1 ../../VLCBlib_PIC/ticktime.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/ticktime.d ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/timedResponse.p1: ../../VLCBlib_PIC/timedResponse.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/timedResponse.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/timedResponse.p1 ../../VLCBlib_PIC/timedResponse.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/timedResponse.d ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/vlcb.p1: ../../VLCBlib_PIC/vlcb.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/vlcb.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/vlcb.p1 ../../VLCBlib_PIC/vlcb.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/vlcb.d ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1: ../../VLCBlib_PIC/event_producer_simple.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c  -D__DEBUG=1  -mdebugger=pickit5   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1 ../../VLCBlib_PIC/event_producer_simple.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.d ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
else
${OBJECTDIR}/_ext/1472/main.p1: ../main.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/main.p1 ../main.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/main.d ${OBJECTDIR}/_ext/1472/main.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/main.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Events.p1: ../canpan3Events.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Events.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Events.p1 ../canpan3Events.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Events.d ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Events.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Inputs.p1: ../canpan3Inputs.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1 ../canpan3Inputs.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Inputs.d ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Inputs.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Nv.p1: ../canpan3Nv.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Nv.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Nv.p1 ../canpan3Nv.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Nv.d ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Nv.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1472/canpan3Outputs.p1: ../canpan3Outputs.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1 ../canpan3Outputs.c 
	@-${MV} ${OBJECTDIR}/_ext/1472/canpan3Outputs.d ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1472/canpan3Outputs.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/boot.p1: ../../VLCBlib_PIC/boot.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/boot.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/boot.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/boot.p1 ../../VLCBlib_PIC/boot.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/boot.d ${OBJECTDIR}/_ext/1954642981/boot.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/boot.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/can18_can_2.p1: ../../VLCBlib_PIC/can18_can_2.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1 ../../VLCBlib_PIC/can18_can_2.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/can18_can_2.d ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/can18_can_2.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1: ../../VLCBlib_PIC/event_acknowledge.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1 ../../VLCBlib_PIC/event_acknowledge.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.d ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_acknowledge.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_coe.p1: ../../VLCBlib_PIC/event_coe.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_coe.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_coe.p1 ../../VLCBlib_PIC/event_coe.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_coe.d ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_coe.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1: ../../VLCBlib_PIC/event_consumer_simple.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1 ../../VLCBlib_PIC/event_consumer_simple.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.d ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_consumer_simple.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1: ../../VLCBlib_PIC/event_teach_simple.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1 ../../VLCBlib_PIC/event_teach_simple.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.d ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_teach_simple.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/messageQueue.p1: ../../VLCBlib_PIC/messageQueue.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/messageQueue.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/messageQueue.p1 ../../VLCBlib_PIC/messageQueue.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/messageQueue.d ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/messageQueue.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/mns.p1: ../../VLCBlib_PIC/mns.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/mns.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/mns.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/mns.p1 ../../VLCBlib_PIC/mns.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/mns.d ${OBJECTDIR}/_ext/1954642981/mns.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/mns.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/nv.p1: ../../VLCBlib_PIC/nv.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nv.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nv.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/nv.p1 ../../VLCBlib_PIC/nv.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/nv.d ${OBJECTDIR}/_ext/1954642981/nv.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/nv.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/nvm.p1: ../../VLCBlib_PIC/nvm.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nvm.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/nvm.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/nvm.p1 ../../VLCBlib_PIC/nvm.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/nvm.d ${OBJECTDIR}/_ext/1954642981/nvm.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/nvm.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/statusLeds2.p1: ../../VLCBlib_PIC/statusLeds2.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1 ../../VLCBlib_PIC/statusLeds2.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/statusLeds2.d ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/statusLeds2.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/ticktime.p1: ../../VLCBlib_PIC/ticktime.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/ticktime.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/ticktime.p1 ../../VLCBlib_PIC/ticktime.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/ticktime.d ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/ticktime.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/timedResponse.p1: ../../VLCBlib_PIC/timedResponse.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/timedResponse.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/timedResponse.p1 ../../VLCBlib_PIC/timedResponse.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/timedResponse.d ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/timedResponse.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/vlcb.p1: ../../VLCBlib_PIC/vlcb.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/vlcb.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/vlcb.p1 ../../VLCBlib_PIC/vlcb.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/vlcb.d ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/vlcb.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1: ../../VLCBlib_PIC/event_producer_simple.c  nbproject/Makefile-${CND_CONF}.mk 
	@${MKDIR} "${OBJECTDIR}/_ext/1954642981" 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d 
	@${RM} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1 
	${MP_CC} $(MP_EXTRA_CC_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -c   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -DXPRJ_PIC18F27Q83=$(CND_CONF)  -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits $(COMPARISON_BUILD)  -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     -o ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1 ../../VLCBlib_PIC/event_producer_simple.c 
	@-${MV} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.d ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d 
	@${FIXDEPS} ${OBJECTDIR}/_ext/1954642981/event_producer_simple.p1.d $(SILENT) -rsi ${MP_CC_DIR}../  
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.map  -D__DEBUG=1  -mdebugger=pickit5  -DXPRJ_PIC18F27Q83=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800        $(COMPARISON_BUILD) -Wl,--memorysummary,${DISTDIR}/memoryfile.xml -o ${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	@${RM} ${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.hex 
	
	
else
${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../../../MPLABworkspace/CBUS_PIC_Bootloader.X/dist/PIC18F27Q83/production/CBUS_PIC_Bootloader.X.production.hex
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mcpu=$(MP_PROCESSOR_OPTION) -Wl,-Map=${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.map  -DXPRJ_PIC18F27Q83=$(CND_CONF)  -Wl,--defsym=__MPLAB_BUILD=1   -mdfp="${DFP_DIR}/xc8"  -fno-short-double -fno-short-float -memi=wordwrite -mrom=800-1E000 -O1 -fasmfile -maddrqual=ignore -xassembler-with-cpp -I"../../VLCB-defs" -I"../../VLCBlib_PIC" -I"../" -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mno-default-config-bits -std=c99 -gdwarf-3 -mstack=compiled:auto:auto:auto --CODEOFFSET=0x800     $(COMPARISON_BUILD) -Wl,--memorysummary,${DISTDIR}/memoryfile.xml -o ${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}     
	
	
	@echo "Creating unified hex file"
	@"C:/Program Files/Microchip/MPLABX/v6.20/mplab_platform/platform/../mplab_ide/modules/../../bin/hexmate" --edf="C:/Program Files/Microchip/MPLABX/v6.20/mplab_platform/platform/../mplab_ide/modules/../../dat/en_msgs.txt" ${DISTDIR}/CANPAN3.X.${IMAGE_TYPE}.hex ../../../MPLABworkspace/CBUS_PIC_Bootloader.X/dist/PIC18F27Q83/production/CBUS_PIC_Bootloader.X.production.hex -odist/${CND_CONF}/production/CANPAN3.X.production.unified.hex

endif


# Subprojects
.build-subprojects:
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
	cd ../../../MPLABworkspace/CBUS_PIC_Bootloader.X && ${MAKE}  -f Makefile CONF=PIC18F27Q83 TYPE_IMAGE=DEBUG_RUN
else
	cd ../../../MPLABworkspace/CBUS_PIC_Bootloader.X && ${MAKE}  -f Makefile CONF=PIC18F27Q83
endif


# Subprojects
.clean-subprojects:
	cd ../../../MPLABworkspace/CBUS_PIC_Bootloader.X && rm -rf "build/PIC18F27Q83" "dist/PIC18F27Q83"

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(wildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
