	AREA		Problem01, CODE, READONLY
	
Main
		MOV	r0,#0x00					;r0=0x00
		MOV	r1,#0x0F					;r0=0x0F
		MOV	r2,#0x03					;r0=0x03
		MOV	r3,#0x06					;r0=0x06
		LDR	r7,Address1				;point start address
		
Example_1								;start of Example_1
		ADD r4,r2,r3,LSL #1			;r4=r2+(r3*2)
		SUB	r5,r0,r1						;r5=r0-r1
		ADD	r6,r4,r5						;r6=r4+r5
		
		STR	r6,[r7]						;r7=r6
		
Endline									;Endline
		MOV pc,#0;
		
Address1	DCD	&40000				;Address1=0x00040000

END											;End of file