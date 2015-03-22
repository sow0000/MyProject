	AREA		Problem, CODE, READONLY
				ENTRY
start
		LDR	r0, Value1						;Value1
		LDR	r3, Value2						;Value2
		
		LSLS	r0, #1							;delete sign
		MOVCS	r1, #1						;sign bit
		MOV	r2, r0, LSL #8
		LSR	r2, #9								;mantissa bit
		LSR	r0, #24								;exponent bit
		
		LSLS r3, #1								;delete sign
		MOVCS	r4, #1						;sign bit
		MOV	r5, r3, LSL #8
		LSR	r5, #9								;mantissa bit
		LSR	r3, #24								;exponent bit
		
		MOV r6, #1
		ADD	r2, r2, r6, LSL #23				;add 1 to front of mantissa
		ADD	r5, r5, r6, LSL #23	
		
		SUBS	r7, r0, r3						;shiftNum
		ADDPL	r3, r3, r7						;equalize exponent
		LSRPL	r5, r7							;shift mantissa
		RSBMI	r7, r7, #0						;absolute value of shiftNum
		LSRMI	r2, r7							;shift mantissa
		
		CMP r1, r4								;compare sign bit
		ADDEQ	r8, r2, r5						;same sign, add mantissa
		SUBNES	r8, r2, r5					;different sign, sub mantissa
		MOVPL	r9, r1							;new sign
		RSBMI	r8, r8, #0						;absolute value of mantissa
		MOVMI	r9, r4							;new sign
		
normalize											;normalize
		MOV r10, r8, LSR #23				;compare first digit
		CMP	r10, r6
		BEQ	Endline							;normalize finish
		LSRPL	r8, #1							;shift right
		ADDPL	r3, r3, #1						;add exponent
		LSLMI	r8, #1							;shift left
		SUBMI	r3, r3, #1						;sub exponent
		B	normalize								;loop normalize
		
Endline											;Endline
		SUB	r8, r8, r6, LSL #23					;sub from front of mantissa
		ADD	r8, r8, r3, LSL #23				;add exponent
		ADD	r8, r8, r9, LSL #31				;add sign
		
		LDR	r11, TEMPADDR1				;r12->0x40000000
		STR	r8, [r11]							;store result
		
		MOV	pc, #0
		
TEMPADDR1	&	&40000000
Value1	DCI 	0x40F80000					;7.75
Value2	DCI 	0x41040000					;8.25

		END