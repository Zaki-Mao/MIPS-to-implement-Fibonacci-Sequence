#Programmer: Mao Zunjie Student id: 18098531-i011-0019

#PART 1 Here is the original Code, and the improved version is in PART 2.
#the Program can be assembled and run directly now.
#parts of improved code comments are added on PART 2 and detailed explanation on Report.


#PART 1 ORIGINAL CODE
#.text 
#main:
#   li    $v0,  5    
#   syscall	     
#     move $a0,  $v0 
#    jal   fib
#    move  $a0,  $v0 
#    li    $v0,  1   
#    syscall	    
#    li    $v0,  10  
#    syscall
#fib:
#    subu  $sp,  $sp,  32   
#    sw    $ra,  28($sp)   
#    sw    $fp,  24($sp)	   
#    sw    $s0,  20($sp)	  
#    sw    $s1,  16($sp)	  
#    sw    $s2,  12($sp)   
#    addu  $fp,  $sp,  32   
#    move  $s0,  $a0	  
#    blt   $s0, 2, fib_base 
#    sub   $a0,  $s0,  1	   
#    jal   fib
#    move  $s1,  $v0
#    sub   $a0,  $s0,  2	   
#    jal   fib
#    move  $s2,  $v0	 
#    add   $v0,  $s1,  $s2   
#    b     fib_ret
#fib_base:
#    li   $v0,  1
#    ##Part 3. 
#fib_ret:
#    lw    $ra,  28($sp)	  
#    lw    $fp,  24($sp)	  
#    lw    $s0,  20($sp)	 
#    lw    $s1,  16($sp)	  
#    lw    $s2,  12($sp)	 
#    addi  $sp,  $sp,  32  
#    jr    $ra    

# PART 2 IMPROVED CODE        
  .data
 #I add some prompt sentences before user input the number
prompt1: .asciiz "Please enter the sequence index:"
prompt2: .asciiz "The Fibonacci value is:"
valuezero: .asciiz "The Fibonacci value is 0"

.text
#Print prompt1
li $v0, 4
la $a0, prompt1
syscall# Read integer
li $v0, 5
syscall
beq $v0, 0, equalToZero# Call fibonacci
addi $a0 $v0 0 #replace "move" instruction to "addi" instruction
jal fib
addi $a1 $v0 0# save return value to a1

# Print prompt2
li $v0, 4
la $a0, prompt2
syscall
# Print result here
addi $v0 $zero 1
addi $a0 $a1 0
syscall
# Exit
li $v0, 10
syscall## Function int fibonacci (int n)
fib:# Prologue
addi $sp, $sp, -12
sw $ra, 8($sp)
sw $s0, 4($sp)
sw $s1, 0($sp)
move $s0, $a0
li $v0, 1 # return value for terminal condition
ble $s0, 2, fibExit # check terminal condition
addi $a0, $s0, -1 # set args for recursive call to f(n-1)
jal fib
move $s1, $v0 # store result of f(n-1) to s1
addi $a0, $s0, -2 # set args for recursive call to f(n-2)
jal fib
add $v0, $s1, $v0 # add result of f(n-1) to it
fibExit:
lw $ra, 8($sp)
lw $s0, 4($sp)
lw $s1, 0($sp)
addi $sp, $sp, 12
jr $ra## End of function fibonacci
equalToZero:
li $v0, 4
la $a0, valuezero
syscall

