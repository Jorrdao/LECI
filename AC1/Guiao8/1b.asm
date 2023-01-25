# Mapa de Registos
# $a0 = str	
	
	
	.data
str:	.asciiz	"2020 e 2024 sao anos bissextos"
str2:	.asciiz "\n"
	.eqv	print_int10, 1
	.eqv	print_string, 4
	.text
	.globl main
	
main:	addiu	$sp, $sp, -4		# criar espaço na stack
	sw	$ra, 0($sp)		# guardar valor de $ra	
	la	$a0, str		#
	jal	atoi			#
	move	$a0, $v0		#	
	li	$v0, print_int10	#
	syscall				# print_int10(atoi(str))
	la	$a0, str2		#
	li	$v0, print_string	#
	syscall				# print_string(\n)
	li	$v0, 0			#
	lw	$ra, 0($sp)		# devolver o valor de $ra
	addiu	$sp, $sp, 4		# pilha restorada
	jr	$ra			# return 0;
	
# Funções	
	
atoi:		
		li	$v0, 0			# res = 0
whileatoi:	
		bgt	$t0, '9', endatoi	#
		blt	$t0, '0', endatoi	# while( (*s >= '0') && (*s <= '9') ){
		addi	$t1, $t0, -0x30		#	digit = *s++ - '0'
		addiu	$a0, $a0, 1		#	s++;
		mul	$v0, $v0, 10		#
		add	$v0, $v0, $t1		#	res = 10 * res + digit
		j	whileatoi		# }
endatoi:	
		
		jr	$ra			# fim da função