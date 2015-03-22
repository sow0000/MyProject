	AREA		ARMex, CODE, READONLY
				ENTRY

start
			MOV		r1, #10
			MOV		r2, #3
			ADD		r0, r1, r2
			CMP		r0, r1
			ADDCS	r0, r0, r2
			CMP		r1, r0
			ADDCS	r0, r1, r1
			
			END