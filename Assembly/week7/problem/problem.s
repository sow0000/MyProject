CR  EQU 0x0D												;End of string
SPC  EQU 0x20											;Space bar

	AREA		Problem, CODE, READONLY 
	ENTRY
	
Main
	LDR	r6, =Arr1 											;Address of Arr1
	LDR	r7, =Arr2 											;Address of Arr2
	EOR	r5, r5, r5											;Clear r5
	
	LDMFD	r6, {r0-r4}									;Load string of Arr1
	MOV lr, pc												;Point next address of CopyArr
	B CopyArr												;Go to CopyArr 
	
	STRB r5, K												;Save count number
	
	MOV pc,#0
	
CopyArr														;CopyArr
	STMFD	sp!, {r0-r4, lr}								;Store r0~r4 and lr in stack
	
Loop
	LDRB	r8, [r6], #1									;First data of Arr1
	CMP	r8,#1												;r8==K?
	BEQ	Loop												;go to Loop assignment
 
	CMP	r8, #CR											;r8==CR?
	LDMFDEQ  sp!, {pc,r0-r4}						;Reset values and exit CopyArr
	
	CMP	r8, #SPC											;r8==SPC?
	ADDNE	r5, r5, #1										;Add count number
	STRBNE	r8, [r7], #1								;Copy in Arr2

	BAL	Loop												;Go to Loop
	
	AREA		dataArray, DATA 
	
K																	;Size of Arr2
	DCB 1														;K=1
	
Arr1																;Original string
	DCB	"Hello, World", CR								;Arr1={Hello, World}
	ALIGN
	
Arr2																;Copied string
	DCB	0														;Arr2={null}
	END															;End of file