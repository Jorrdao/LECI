# Mapa de Registos
# $t0 - p
# $t1 - pultimo
# $t2 - SIZE*4

	.data
str1:	.asciiz	"Array" 
str2:	.asciiz "de"
str3:	.asciiz "Ponteiros"
	.align 2
array:	.word str1, str2, str3
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv SIZE, 3
	.text
	.globl main
	
main:	la	$t0, array
	li	$t2, SIZE
	sll	$t2, $t2, 2
	addu	$t1, $t2, $t0
	
while:	bge	$t0, $t1, end
	lw	$a0, 0($t0)
	li	$v0, print_string
	syscall
	li	$a0, '\n'
	li	$v0, print_char
	syscall
	addi	$t0, $t0, 4
	j	while
	
end:	jr	$ra