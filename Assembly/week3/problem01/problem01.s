	AREA		ARMex, CODE, READONLY
				ENTRY

start
		LDR		r0, TEMPADDR1	;Save address "0x40000000" into r4
		MOV		r1, #1					;Input 1 into r1
		STR		r1, [r0], #4			;Input 1! into 0x40000000 and move to 0x40000004
		
		MOV		r1, r1, LSL #1		;1x2
		STR		r1, [r0], #4			;Input 2! into 0x40000004 and move to 0x40000008
		
		ADD		r1, r1, r1, LSL #1	;1x2+1x2x2=1x2x3
		STR		r1, [r0], #4			;Input 3! into 0x40000008 and move to 0x4000000C
		
		MOV		r1, r1, LSL #2		;1x2x3x4
		STR		r1, [r0], #4			;Input 4! into 0x4000000C and move to 0x40000010

		ADD		r1, r1, r1, LSL #2	;1x2x3x4+1x2x3x4x4=1x2x3x4x5
		STR		r1, [r0], #4			;Input 5! into 0x40000010 and move to 0x40000014
		
		MOV		r2, r1, LSL #1		;1x2x3x4x5x2
		ADD		r1, r2, r1, LSL #2	;1x2x3x4x5x2+1x2x3x4x5x4=1x2x3x4x5x6
		STR		r1, [r0], #4			;Input 6! into 0x40000014 and move to 0x40000018

		ADD		r2, r1, r1, LSL #1	;1x2x3x4x5x6+1x2x3x4x5x6x2=1x2x3x4x5x6x3
		ADD		r1, r2, r1, LSL #2	;1x2x3x4x5x6x3+1x2x3x4x5x6x4=1x2x3x4x5x6x7
		STR		r1, [r0], #4			;Input 7! into 0x40000018 and move to 0x4000001C
		
		MOV		r1, r1, LSL #3		;1x2x3x4x5x6x7x8
		STR		r1, [r0], #4			;Input 8! into 0x4000001C and move to 0x40000020
		
		ADD		r1, r1, r1, LSL #3	;1x2x3x4x5x6x7x8x8+1x2x3x4x5x6x7x8=1x2x3x4x5x6x7x8x9
		STR		r1, [r0], #4			;Input 9! into 0x40000020 and move to 0x40000024

		MOV		r2, r1, LSL #1		;1x2x3x4x5x6x7x8x9x2
		ADD		r1, r2, r1, LSL #3	;1x2x3x4x5x6x7x8x9x2+1x2x3x4x5x6x7x8x9x8=1x2x3x4x5x6x7x8x9x10
		STR		r1, [r0]				;Input 10! into 0x40000024

TEMPADDR1	&	&40000000	;TEMPADDR1=0x40000000

		END									;End of file