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

slt $t1, $v0, $zero      #is value < 0 ?
beq $t1, $zero, ADD_INT  #if r1 is positive, skip next inst
sub $v0, $zero, $v0      #r2 = 0 - r1
j ADD_INT

ADD_INT:
    addu    $s0, $s0, $v0
    bne $v0, $zero, LOOP

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