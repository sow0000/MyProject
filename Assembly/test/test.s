	AREA ARMex, CODE, READONLY
		ENTRY
			
start
		MOV		r0, #10
		MOV		r1,#3
		ADD		r0,r0,r1
		
		MOV		pc,lr
		END						; Mark end of file
