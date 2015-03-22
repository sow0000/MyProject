	AREA		Exercise1, CODE, READONLY
				ENTRY
				
start
		MOV		r0, #10					;set up parameters
		MOV		r1, #3
		
		LDR		r2, TEMPADDR1
		MOV		lr, pc					;save return address
		B			doadd					;call subroutine
		SUB		r0, r0, r1				;subtraction
		STR		r0, [r2]				;store on mem
		
stop
		MOV		pc,#0
		
doadd
		ADD		r0, r0, r1				;addition
		STR		r0, [r2], #4			;store on mem
		MOV		pc, lr					;return
		
TEMPADDR1	&	&00040000

		END