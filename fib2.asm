#programmer: Mao Zunjie 18098531-i011-0019 lab1.2 
#This program can output fibonacci sequence f(1),f(2)...f(n) , different from single number in lab1.1, it's a sequence
  .data
array: 	.space 1024
inputbegin:	.asciiz "Input a number:"
runend:	.asciiz "\nend\n"
.text	
	li $v0,4
	la $a0,inputbegin #user input the number
	syscall 
	li $v0,5 
	syscall
	move $t2,$v0        
	move $t3,$t2
	li $t0,1		#set array(0) and array(1) = 1
	la $t1,array
	sw $t0,($t1)
	sw $t0,4($t1)
	blt $t2,3,print	#if n<3 ,just print,needless of recursion
	
Fib:	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $t2,4($sp)
	#base case
	beq $t2,2,re	#when $t2=2 ,we're gonna return
	addi $t2,$t2,-1
	jal Fib
	# Fib(n)=Fib(n-1)+Fib(n-2)
	move $t4,$0
	lw $a0,($t1)
	lw $a1,4($t1)
	add $t4,$a1,$a0
	sw $t4,8($t1)
	
	addi $t1,$t1,4
	beq $t2,$t3,print
	
re:	lw $ra,0($sp) 
	addi $t2,$t2,1
	addi $sp,$sp,8
	jr $ra

print:	la $t1,array
	li $t3,1
loop1:	lw $a0,($t1)
	li $v0,1
	syscall
	
	li $v0,11
	li $a0,' '
	syscall
	
	beq $t3,$t2,end
	addi $t3,$t3,1
	addi $t1,$t1,4
	b loop1

end:	li $v0,4  
	la $a0,runend
	syscall
	li $v0,10
	syscall
	
