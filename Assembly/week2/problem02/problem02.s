	AREA		ARMex, CODE, READONLY
				ENTRY
				
start
		MOV		r0, #0x01				;Input 0x01 into r0
		MOV		r1, #0x02				;Input 0x02 into r1
		MOV		r2, #0x03				;Input 0x03 into r2
		MOV		r3, #0x04				;Input 0x03 into r3
		
		LDR		r4, TEMPADDR1	;Save address "0x00001000" into r4
		
		STRB	r0, [r4], #1			;Input r0 into 0x00001000 and move to 0x00001001
		STRB	r1, [r4], #1			;Input r1 into 0x00001001 and move to 0x00001002
		STRB	r2, [r4], #1			;Input r2 into 0x00001002 and move to 0x00001003
		STRB	r3, [r4], #-3			;Input r3 into 0x00001003 and move to 0x00001000
		
		LDR		r5, [r4]				;Input value in memory r4 into r5
		
		STRB	r2, [r4], #2			;Input r2 into 0x00001000 and move to 0x00001002
		STRB	r0, [r4], #1			;Input r0 into 0x00001002 and move to 0x00001003
		
		LDR		r6, [r4]				;Input value in memory r4 into r6
		
TEMPADDR1	&	&00001000	;TEMPADDR1=0x00001000

		END									;Mark end of file