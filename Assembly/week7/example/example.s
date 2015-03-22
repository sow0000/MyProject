CR	EQU	0x0D

	AREA		Example, CODE, READONLY
	ENTRY

Main
	LDR	r0, =Table
	EOR	r1, r1, r1
	
Loop
	LDRB	r2, [r0], #1
	CMP	r2, #CR
	BEQ	Done
	ADD	r1, r1, #1
	
	BAL	Loop
	
Done
	STR	r1, CharCount
	SWI	&11
	
	AREA	Data1, DATA
	
Table
	DCB	"Hello, World", CR
	ALIGN
	
	AREA	Result, DATA

CharCount
	DCB	0
	
	END