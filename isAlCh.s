#Program Name: isAlCh.s
#Author: Johnnie Massart
#Date: 10/28/23
#Purpose: determine if alpha char or not
.text
.global main
main:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#user prompt
	LDR r0, =prompt
	BL printf

	#scan user input
	LDR r0, =formatInput
	LDR r1, =input
	BL scanf

	#store user input value
	LDR r1, =input
	LDR r1, [r1]

	#call function
	BL AlCh

	#re-store value
	MOV r1, r7

	#output
	LDR r0, =output
	BL printf

	#pop the stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	prompt: .asciz "Enter decimal value for an ASCII char: "
	formatInput: .asciz "%d"
	input: .word 0
	output: .asciz "The input entered %s character\n"
#End main

.text
AlCh:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#determine if decimal value is within range
	#65-90 (uppercase)
	MOV r2, #0
	CMP r1, #65
	ADDGE r2, #1

	MOV r3, #0
	CMP r1, #90
	ADDLE r3, #1
	AND r2, r2, r3

	#97-122 (lowercase)
	MOV r4, #0
	CMP r1, #97
	ADDGE r4, #1

	MOV r5, #0
	CMP r1, #122
	ADDLE r5, #1
	AND r4, r4, r5

	#add (or did not work) - upper/lowercase
	ADD r2, r2, r4

	#determine if decimal value is valid or not
	CMP r2, #0
	BGT else
		#grade is not valid
		LDR r7, =isNotValid
		B endIf
	else:
		#grade is valid
		LDR r7, =isValid
		B endIf
	endIf:

	#pop the stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	isValid: .asciz "is an alphabetic"
	isNotValid: .asciz "is not an alphabetic"
