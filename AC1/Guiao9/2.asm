	.data
	.eqv read_double, 7
	.eqv print_double, 3
	.eqv print_string, 4
str1:	.asciiz "Fahrenheit: "
str2:	.asciiz "Celsius: "
k0:	.double 5.0
k1:	.double 9.0
k2:	.double 32.0
	.text
	.globl main
	
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, str1
	li	$v0, print_string
	syscall
	li	$v0, read_double
	syscall
	mov.d	$f12, $f0
	jal	f2c
	
	la	$a0, str2
	li	$v0, print_string
	syscall
	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra
	
f2c:	la	$t0, k0
	la	$t1, k1
	la	$t2, k2
	l.d	$f4, 0($t0)
	l.d	$f6, 0($t1)
	l.d	$f8, 0($t2)
	sub.d	$f18, $f12, $f8
	div.d	$f16, $f4, $f6
	mul.d	$f0, $f16, $f18
	jr	$ra 	
