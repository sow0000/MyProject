	AREA		ARMex, CODE, READONLY
				ENTRY
				
start
		MOV	r0, #16
		MOV	r1, #10
		MOV	r2, #08
		MOV	r3, #34
		
		LDR	r4, TEMPADDR1
		STRB	r0, [r4], #2
		STRB	r1, [r4], #2
		STRB	r2, [r4], #2
		STRB	r3, [r4]
		
TEMPADDR1	&	&00001000
	
		END