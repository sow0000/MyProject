	AREA		Problem02, CODE, READONLY
				ENTRY

start
		MOV		r0, #0							;r0=0
		MOV		r1, #1							;r1=1
		MOV		r2, #2							;r2=2
		MOV		r3, #3							;r3=3
		MOV		r4, #4							;r4=4
		MOV		r5, #5							;r5=5
		MOV		r6, #6							;r6=6
		MOV		r7, #7							;r7=7
		
		MOV		lr, pc							;save return address
		B			doRegister					;go to doRegister
		TST		r8, #1							;check odd or even
		BEQ		evensub						;go to evensub
		SUB		r8, r8, r1						;subtract odd-indexed registers
		SUB		r8, r8, r3
		SUB		r8, r8, r5
		SUB		r8, r8, r7
		B			stop								;go to stop
		
evensub											;evensub
		SUB		r8, r8, r0						;subtract even-indexed registers
		SUB		r8, r8, r2
		SUB		r8, r8, r4
		SUB		r8, r8, r6
		
stop													;stop
		LDR		r9, TEMPADDR1			;point start address
		STR		r8, [r9]						
		MOV		pc, #0
		
doRegister
		STMFD	sp!, {lr, r0-r7}				;PUSH into stack
		LDMFD	sp!, {r1,r6}					;POP from stack
		LDMFD	sp!, {r0,r2,r7}				;POP from stack
		LDMFD	sp!, {r3-r5}					;POP from stack
		
		ADD		r8, r8, r1						;r1
		ADD		r8, r8, r2, LSL #1			;r2
		ADD		r8, r8, r3, LSL #1			;r3
		ADD		r8, r8, r3
		ADD		r8, r8, r4, LSL #2			;r4
		ADD		r8, r8, r5, LSL #2			;r5
		ADD		r8, r8, r5
		ADD		r8, r8, r6, LSL #2			;r6
		ADD		r8, r8, r6, LSL #1
		ADD		r8, r8, r7, LSL #3			;r7
		SUB		r8, r8, r7
		
		LDMFA	sp!, {pc, r0-r7}			;POP from stack

TEMPADDR1	&	&00040000			;TEMPADDR1=0x00040000
		
		END											;End of file