	AREA		ARMex, CODE, READONLY
				ENTRY

start
		LDR		r0, TEMPADDR1	;Save address "0x40000000" into r4
		MOV		r1, #1					;Input 1 into r1
		STR		r1, [r0], #4			;Input 1! into 0x40000000 and move to 0x40000004
		
		MOV		r2, #2					;Input 2 into r2
		MUL		r1, r2, r1				;1x2
		STR		r1, [r0], #4			;Input 2! into 0x40000004 and move to 0x40000008
		
		MOV		r2, #3					;Input 3 into r2
		MUL		r1, r2, r1				;1x2x3
		STR		r1, [r0], #4			;Input 3! into 0x40000008 and move to 0x4000000C
		
		MOV		r2, #4					;Input 4 into r2
		MUL		r1, r2, r1				;1x2x3x4
		STR		r1, [r0], #4			;Input 4! into 0x4000000C and move to 0x40000010

		MOV		r2, #5					;Input 5 into r2
		MUL		r1, r2, r1				;1x2x3x4x5
		STR		r1, [r0], #4			;Input 5! into 0x40000010 and move to 0x40000014
		
		MOV		r2, #6					;Input 6 into r2
		MUL		r1, r2, r1				;1x2x3x4x5x6
		STR		r1, [r0], #4			;Input 6! into 0x40000014 and move to 0x40000018

		MOV		r2, #7					;Input 7 into r2
		MUL		r1, r2, r1				;1x2x3x4x5x6x7
		STR		r1, [r0], #4			;Input 7! into 0x40000018 and move to 0x4000001C
		
		MOV		r2, #8					;Input 8 into r2
		MUL		r1, r2, r1				;1x2x3x4x5x6x7x8
		STR		r1, [r0], #4			;Input 8! into 0x4000001C and move to 0x40000020
		
		MOV		r2, #9					;Input 9 into r2
		MUL		r1, r2, r1				;1x2x3x4x5x6x7x8x9
		STR		r1, [r0], #4			;Input 9! into 0x40000020 and move to 0x40000024

		MOV		r2, #10					;Input 10 into r2
		MUL		r1, r2, r1				;1x2x3x4x5x6x7x8x9x10
		STR		r1, [r0]				;Input 10! into 0x40000024

TEMPADDR1	&	&40000000	;TEMPADDR1=0x40000000

		END									;End of file