	AREA		Problem03_1, CODE, READONLY

Main
		LDR	r0,Address1				;point start address
		MOV	r1,#0						;r1=0
		
Loop										;start of Loop
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+r1
		
		CMP	r1,#10						;compare r1 and 10
		BEQ	Endline					;if r1==10, go to Endline
		B	Loop							;go to Loop
		
Endline									;Endline
		STR	r2,[r0]						;r0=r2
		MOV	pc,#0;
		
Address1	DCD	&00040000		;Address1=0x00040000

END											;End of file