	AREA		ARMex, CODE, READONLY
				ENTRY
				
start
		MOV		r0, #1
		MOV		r1, #-1
		MOV		r2, #8
		
		SUBS	r4, r0, #0
		MOVPL	r3, r0
		
		SUBS	r4, r1, #0
		ADDMI	r3, r3, r1
		
		SUBS	r4, r2, #7
		ADDLE	r3, r3, r2
		
		SUBS	r4,r3, #0
		MOVEQ	r3, r0
		
		END