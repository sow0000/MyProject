	AREA		Problem01, CODE, READONLY
				ENTRY

start
		MOV		r0, #0					;r0=0
		MOV		r1, #1					;r1=1
		MOV		r2, #2					;r2=2
		MOV		r3, #3					;r3=3
		MOV		r4, #4					;r4=4
		MOV		r5, #5					;r5=5
		MOV		r6, #6					;r6=6
		MOV		r7, #7					;r7=7
		
		LDR		sp, TEMPADDR1	;point start address
		
		STMFA	sp!, {r0-r7}			;PUSH into stack
		LDMFA	sp!, {r3-r5}			;POP from stack
		LDMFA	sp!, {r0,r2,r7}		;POP from stack
		LDMFA	sp!, {r1,r6}			;POP from stack
		
		MOV		pc,#0
		
TEMPADDR1	&	&00040000	;TEMPADDR1=0x00040000
		
		END									;End of file