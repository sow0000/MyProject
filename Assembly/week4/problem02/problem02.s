	AREA		Problem02, CODE, READONLY
	
Main
		LDR	r0,=C_string				;call the arry pointer
		LDR	r1,Address1				;point start address
		MOV	r3,#0						;r3=0
		
Strlen										;start of Strlen
		LDRB	r2,[r0],#1				;read character from string
		CMP	r2,#0						;compare r2 and 0
		BEQ	Endline					;if r2==0, go to Endline
		
		ADD r3,r3,#1						;r3++
		B	Strlen							;go to Strlen
Endline									;Endline
		STR	r3,[r1]						;r1=r3
		MOV	pc,#0;
		
C_string	DCB	"Hello world",0	;C_string="Hello world"
Address1	DCD	&00040000		;Address1=0x00040000

END											;End of file