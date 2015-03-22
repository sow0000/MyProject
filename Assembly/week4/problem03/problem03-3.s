	AREA		Problem03_3, CODE, READONLY
	
Main
		LDR	r0,Address1				;point start address
		MOV	r1,#2						;r1=2
		MOV	r2,#1						;r2=1
		
		ADD	r2,r2,r1						;r2=1+2
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+3
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+4
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+5
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+6
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+7
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+8
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+9
		ADD	r1,r1,#1					;r1++
		ADD	r2,r2,r1						;r2=r2+10

		STR	r2,[r0]						;r0=r2
		MOV	pc,#0;
		
Address1	DCD	&00040000		;Address1=0x00040000

END											;End of file