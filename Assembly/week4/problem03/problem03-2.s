	AREA		Problem03_2, CODE, READONLY
	
Main
		LDR	r0,Address1				;point start address
		MOV	r1,#10						;r1=10
		
		ADD	r2,r1,#1					;r2=r1+1
		MUL	r3,r2,r1						;r3=r2*r1
		LSR	r3,#1						;r3/2

		STR	r3,[r0]						;r0=r3
		MOV	pc,#0;
		
Address1	DCD	&00040000		;Address1=0x00040000

END											;End of file