	AREA		ARMex, CODE, READONLY
				ENTRY
				
start
		LDR		r0, TEMPADDR1	;Save address "0x00001000" into r0
		MOV		r1, #0x11				;Input 0x11 into r1
		MOV		r2, #0x0A				;Input 0x0A into r2

		STRB	r1, [r0]				;Input r1 into 0x00001000
		LDRB	r3, [r0]				;Load value of memory r0 and put it into r3
		
		SUBS	r4, r3, r2				;Substract r2 from r3 and input result into r4 setting flag of CPSR
		MOVGT	r5, #1				;If r3 is bigger than r2, input 1 into r5
		MOVEQ	r5, #2				;If r3 is equal to r2, input 2 into r5
		MOVLT		r5, #3				;If r3 is smaller than r2, input 3 into r5
		
TEMPADDR1	& &00001000		;TEMPADDR1=0x00001000

		END									;Mark end of file