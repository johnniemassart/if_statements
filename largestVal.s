#Program Name: largestVal.s
#Author: Johnnie Massart
#Date: 10/29/2023
#Purpose: return largest value input by user
.text
.global main
main:
	#push the stack
	SUB sp, sp, #4
	STR lr, [sp]
	
	#user val1 prompt
	LDR r0, =val1Prompt
	BL printf

	#scan user val1 input
	LDR r0, =formatVal1
	LDR r1, =val1
	BL scanf

	#store user val1 input
	LDR r6, =val1
	LDR r6, [r6]

	#user val2 prompt
	LDR r0, =val2Prompt
	BL printf

	#scan user val2 input
	LDR r0, =formatVal2
	LDR r1, =val2
	BL scanf

	#store user val2 input
	LDR r7, =val2
	LDR r7, [r7]

	#user val3 prompt
	LDR r0, =val3Prompt
	BL printf

	#scan user val3 input
	LDR r0, =formatVal3
	LDR r1, =val3
	BL scanf

	#store user val3 input
	LDR r8, =val3
	LDR r8, [r8]

	#call function
	BL findMaxOf3

	#re-store values
	MOV r1, r4
	
	#output message
	LDR r0, =output
	BL printf

	#pop the stack
	LDR lr, [sp]
	ADD sp, sp, #4
	MOV pc, lr
.data
	val1Prompt: .asciz "Enter val1: "
	val2Prompt: .asciz "Enter val2: "
	val3Prompt: .asciz "Enter val3: "
	formatVal1: .asciz "%d"
	formatVal2: .asciz "%d"
	formatVal3: .asciz "%d"
	val1: .word 0
	val2: .word 0
	val3: .word 0
	output: .asciz "The largest value is: %s\n"

#End main

.text
findMaxOf3:
	#push the stack
	SUB sp, sp, #8
	STR lr, [sp]
	STR r4, [sp, #4]

	#compare val1, val2
	CMP r6, r7
	BLE elsif_1
		LDR r4, =v1
		#compare val1, val3
		CMP r6, r8
		BLE elsif_3
			LDR r4, =v1
			B endIf
		elsif_3:
			LDR r4, =v3
			B endIf
	elsif_1:
		LDR r4, =v2
		#compare val2, val3
		CMP r7, r8
		BLE elsif_4
			LDR r4, =v2
			B endIf
		elsif_4:
			LDR r4, =v3
			B endIf

	endIf:

	#pop the stack
	LDR lr, [sp]
	ADD sp, sp, #8
	MOV pc, lr
.data
	v1: .asciz "val1"
	v2: .asciz "val2"
	v3: .asciz "val3"	
