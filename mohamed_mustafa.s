.data
	int_specifier:	 .asciz "%d"
	char_specifier:	 .asciz "%s"
	num1_buffer:	 .space 32
	num2_buffer:	 .space 32
	char_buffer:	 .space 32
	newLine:	 .asciz "\n"
	div0:		 .asciz "Cannot divide by 0"
	
.global main

.text

main:
	//Input first number
	ldr x0, =int_specifier
	ldr x1, =num1_buffer
	bl scanf

	//Input second number
	ldr x0, =int_specifier
	ldr x1, =num2_buffer
	bl scanf
	
	//Input operation
	ldr x0, =char_specifier
	ldr x1, =char_buffer
	bl scanf
	
	//Load temps to storage
	ldr x0, =num1_buffer
	ldr x1, =num2_buffer
	ldr x2, =char_buffer

	ldr x19, [x0, #0]
	ldr x20, [x1, #0]
	ldrb w21, [x2, #0]	
	//x22 blank
	
	bl operation

	ldr x0, =int_specifier

	//read out result
	mov x1, x23
	bl printf	

	b exit

operation:
   	//ADD
	cmp w21, #43
    	beq ADD

	//SUB
    	cmp w21, #45
	beq SUB
	
	//MUL
    	cmp w21, #42
 	beq MUL

	//DIV
	cmp w21, #47
 	beq DIV 

ADD:
	add x23, x19, x20
	br x30
SUB:
	sub x23, x19, x20
	br x30
MUL:
	mul x23, x19, x20
	br x30
DIV:
	//check b=0
	cbz w20, DIVZero
	
	sdiv x23, x19, x20
	br x30
DIVZero:
	ldr x0, =char_specifier
	ldr x1, =div0
	bl printf
	b exit
exit:
	ldr x0, =newLine
	bl printf
	mov x0, #0
	mov x8, #93
	svc #0
