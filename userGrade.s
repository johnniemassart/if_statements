#Program Name: userGrade.s
#Author: Johnnie Massart
#Date: 10/28/23
#Purpose: determine user grade
.text
.global main
main:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp, #0]

	#user name prompt
	LDR r0, =namePrompt
	BL printf
	
	#scan user name input
	LDR r0, =formatName
	LDR r1, =name
	BL scanf

	#store user name input
	LDR r8, =name

	#user average prompt
	LDR r0, =avgPrompt
	BL printf

	#scan user average input
	LDR r0, =formatAvg
	LDR r1, =avg
	BL scanf

	#store user average input
	LDR r0, =avg
	LDR r0, [r0]

	#call function
	BL printGrades

	#re-store values
	MOV r1, r8
	MOV r2, r5	

	#output message
	LDR r0, =output
	BL printf

	#pop the stack
	LDR lr, [sp, #0]
	ADD sp, sp, #4
	MOV pc, lr
.data
	namePrompt: .asciz "Enter your name: "
	avgPrompt: .asciz "Enter your average: "
	formatName: .asciz "%s"
	formatAvg: .asciz "%d"
	name: .space 40
	avg: .word 0
	output: .asciz "Your name is %s and you received a grade of %s\n"

#End main

.text
printGrades:
	#push the stack
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]

	#store r0 in r4
	MOV r4, r0

	#determine if avg input is valid
	MOV r0, #0
	CMP r4, #0
	ADDGE r0, r0, #1
	MOV r1, #0
	CMP r4, #100
	ADDLE r1, r1, #1
	AND r0, r0, r1

	#if statement - valid or invalid avg
	CMP r0, #1
	BGE else
		#grade is not valid
		LDR r5, =invalid
		B endIf
	else:
		#grade is valid
		#nested if statement - correlate avg to grade
		CMP r4, #70
		BGE elsif_1
			LDR r5, =F
			B endIf
		elsif_1:
			CMP r4, #80
			BGE elsif_2
			LDR r5, =C
			B endIf
		elsif_2:
			CMP r4, #90
			BGE elsif_3
			LDR r5, =B
			B endIf
		elsif_3:
			LDR r5, =A
			B endIf
	
	endIf:
	
	#pop the stack
	LDR lr, [sp, #0]
	LDR r4, [sp, #4]
	ADD sp, sp, #8
	MOV pc, lr
.data
	invalid: .asciz "invalid"
	A: .asciz "A"
	B: .asciz "B"
	C: .asciz "C"
	F: .asciz "F"	
