	AREA		Example, CODE, READONLY
	
Main
		;STMFD	sp!,{r1-r12,lr}
		LDR	r0,=Value1				;call the arry pointer
		LDR	r1,Address1				;point start address
		MOV	r6,#6						;size of array
		
Loop										;start of Loop
		LDR	r2,[r0],#4					;read data from arry
		CMP	r2,#0						;compare r2 and 0
		
		BLT	less							;if r2<0, go to less
		MUL	r3,r2,r2						;r3=r2*r2
		MUL	r4,r3,r3						;r4=r3*r3
		MUL	r7,r3,r2						;r7=r3*r2
		MUL	r8,r4,r2						;r8=r4*r2
		SUB	r2,r8,r7						;r2=r8-r7
		B		Finish						;go to Finish
		
less											;start of less
		MUL	r3,r2,r2						;r3=r2*r2
		MUL	r4,r3,r3						;r4=r3*r3
		MUL	r7,r3,r4						;r7=r3*r4
		ADD	r2,r7,r4						;r2=r7+r4
		
Finish										;Finish
		STR	r2,[r1],#4					;save r2 into r1 and move next 4bits
		ADD	r5,r5,#1					;r5++
		CMP	r5,r6							;compare r5 and r6
		BEQ	Endline					;if r5==r, go to Endline
		B	Loop							;if r5!=r6, go to Loop
		
Endline									;Endline
		;LDMFD	sp!,{r1-r12,pc}
		MOV	pc,lr;
		
Value1	DCD	3,2,-3,-2,10,0		;Value1={3,2,-3,-2,10,0}
Address1	DCD	&40000000		;Address1=0x40000000

END											;End of file