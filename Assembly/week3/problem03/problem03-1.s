	AREA		ARMex, CODE, READONLY
				ENTRY

start
		MOV		r0, #3					;Input 3 into r0
		MOV		r1, #17					;Input 17 into r1
		
		ADD		r0, r0, r0, LSL #4	;3+3x16=3X17
		ADD		r1, r1, r1, LSL #1	;17+17x2=17x3

		END									;End of file