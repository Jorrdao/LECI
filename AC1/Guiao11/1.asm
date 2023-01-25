	.data
	.eqv	print_string, 4
	.eqv	print_intu10, 36
	.eqv	print_float, 2
	.eqv	print_char, 11
	.eqv	id_number, 0
	.eqv	first_name, 4
	.eqv	last_name, 22
	.eqv	grade, 40

stg:	.word	72343
	.asciiz	"Napoleao"
	.space 9
	.asciiz "Bonaparte"
	.space 5
	.float	5.01

str1:	.asciiz	"\nNome: "
str2:	.asciiz "\nN. Mec: "
str3:	.asciiz "\nNota: "
	.text
	.globl main
	
main:	la	$t0, stg		# $t0 = &stg
	la	$a0, str2		#
	li	$v0, print_string	#
	syscall				# print_string(str2)
	lw	$a0, id_number($t0)	#
	li	$v0, print_intu10	#
	syscall				# print_intu10(id_number)
	
	la	$a0, str1		#
	li	$v0, print_string	#
	syscall				# print_string(str1)
	addiu	$a0, $t0, last_name	#
	li	$v0, print_string	#
	syscall				# print_string(last_name)
	li	$a0, ','		#
	li	$v0, print_char		#
	syscall				# print_char(,)
	addiu	$a0, $t0, first_name	#
	li	$v0, print_string	#
	syscall				# print_string(first_name)
	
	la	$a0, str3		#
	li	$v0, print_string	#
	syscall				# print_string(str3)
	l.s	$f12, grade($t0)	#
	li	$v0, print_float	#
	syscall				# print_float(grade)
	
end:	li	$v0, 0			#
	jr	$ra			# fim do programa
	
	
	
	
	