.data
prompt_for_input: .asciiz "Please enter your numbers, pressing enter after each, (0 to terminate):\n"
prompt_for_output: .asciiz "Your quantity of interest is equal to: "

.text
main:
# prompting the user with a message for a string input:
li $v0, 4
la $a0, prompt_for_input
syscall

li  $s0, 0

LOOP: 
    li  $v0, 5
    syscall 

    beq $v0, $zero, EXIT_LOOP
    li  $t0, 0x00

    slt $t1, $v0, $zero      #is value < 0 ?
    beq $t1, $zero, SKIP     #if r1 is positive, skip next inst
    sub $v0, $zero, $v0      #r2 = 0 - r1
    j CHECK_SECOND

    CHECK_SECOND:
        andi $t1, $v0, 0x03
        bne $t1, $zero, SKIP
        andi $t0, $t0, 0x01


    ADD_INT:
        addi    $s0, $s0, 1
        bne $v0, $zero, LOOP
    
    SKIP:
        j LOOP
    
EXIT_LOOP:
    # prompting the user with a message for the processed output:
    li $v0, 4
    la $a0, prompt_for_output
    syscall

    # printing the output
    addiu  $v0, $zero, 1
    addu $a0, $zero, $s0
    syscall

    # Finish the programme:
    li $v0, 10      # syscall code for exit
    syscall         # exit