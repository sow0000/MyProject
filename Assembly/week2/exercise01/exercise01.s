	AREA		ARMex, CODE, READONLY
				ENTRY
				
start
		MOV		r0, #10
		MOV		r1, #3
		CMP		r0, r1
		MOVMI	r2, r0
		MOVGT	r2, r1
		ADDEQ		r2, r0, r1
		
		END