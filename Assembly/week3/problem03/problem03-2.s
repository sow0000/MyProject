	AREA		ARMex, CODE, READONLY
				ENTRY

start
		MOV		r0, #3					;Input 3 into r0
		
		ADD		r1, r0, r0				;3x2
		ADD		r1, r1, r0				;3x3
		ADD		r1, r1, r0				;3x4
		ADD		r1, r1, r0				;3x5
		ADD		r1, r1, r0				;3x6
		ADD		r1, r1, r0				;3x7
		ADD		r1, r1, r0				;3x8
		ADD		r1, r1, r0				;3x9
		ADD		r1, r1, r0				;3x10
		ADD		r1, r1, r0				;3x11
		ADD		r1, r1, r0				;3x12
		ADD		r1, r1, r0				;3x13
		ADD		r1, r1, r0				;3x14
		ADD		r1, r1, r0				;3x15
		ADD		r1, r1, r0				;3x16
		ADD		r1, r1, r0				;3x17
		
		MOV		r2, #17					;Input 17 into r1
		
		ADD		r3, r2, r2				;17x2
		ADD		r3, r3, r2				;17x3

		END									;End of file