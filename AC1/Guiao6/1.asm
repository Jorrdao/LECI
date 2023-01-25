# Mapa de registos
# $t0 - i
# $t1 - array
# $t2 - i temp
# $t3 - array[i]

	.data
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "Ponteiros"
	.align 2
array:	.word str1, str2, str3
	.eqv SIZE, 3
	.eqv print_char, 11
	.eqv print_string, 4
	.text
	.globl main
	
main:	la	$t1, array
	li	$t0, 0
	
while:	bge	$t0, SIZE, end
	sll	$t2, $t0, 2
	addu	$t3, $t2, $t1
	lw	$t3, 0($t3)
	ori	$a0, $t3, 0
	li	$v0, print_string
	syscall
	li	$a0, '\n'
	li	$v0, print_char
	syscall
	addi	$t0, $t0, 1
	j	while
	
end:	jr	$ra
	
	