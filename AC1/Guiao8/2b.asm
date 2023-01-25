# Mapa de Registos
# $s0 = str
# $s1 = val

	.data
	.eqv	print_string, 4
	.eqv	read_int, 5
	.eqv	MAX_STR_SIZE, 33
str:	.space  MAX_STR_SIZE
	.text
	.globl main
	
########  MAIN  ############
	
main:		addiu		$sp, $sp, -12		# reservar espaço na stack
		sw		$ra, 0($sp)		# guardar o valor de $ra
		sw		$s0, 4($sp)		# guardar registos $s na stack
		sw		$s1, 8($sp)
							# do{
do:		li		$v0, read_int		#	
		syscall					#
		move		$s1, $v0		#	val = read_int
		la		$s0, str		#
		move		$a0, $s1		#
		li		$a1, 2			#
		move		$a2, $s0		#
		jal		itoa			#
		move		$a0, $s0		#
		li		$v0, print_string	#       print_string ( itoa(val, 2, str) )
		syscall					#
		move		$a0, $s1		#
		li		$a1, 8			#
		move		$a2, $s0		#
		jal		itoa			#
		move		$a0, $s0		#
		li		$v0, print_string	#       print_string ( itoa(val, 8, str) )
		syscall					#
		move		$a0, $s1		#
		li		$a1, 16			#
		move		$a2, $s0		#
		jal		itoa			#
		move		$a0, $s0		#
		li		$v0, print_string	#       print_string ( itoa(val, 16, str) )
		syscall					#
while:		bne		$s1, 0, do		# }while(val != 0)
		lw		$ra, 0($sp)		#
		lw		$s0, 4($sp)		#
		lw		$s1, 8($sp)		#
		addiu		$sp, $sp, 12		#
		jr		$ra
		
			
				
####### TOASCII ##########

toascii:	
		addi	$a0, $a0, 0x30
iftoas:		ble	$a0, '9', endtoas
		addi	$a0, $a0, 0x37
endtoas:		move	$v0, $a0
		jr	$ra
		
####### ITOA #########		
		
itoa:		
		addiu	$sp, $sp, -20		# reserva espaço na stack
		sw	$ra, 0($sp)		# Guarda valores que precisamos no fim noutra subrotinas
		sw	$s0, 4($sp)		#
		sw	$s1, 8($sp)		#
		sw	$s2, 12($sp)		#
		sw	$s3, 16($sp)		#
		
		move	$s0, $a0		#
		move	$s1, $a1		#
		move 	$s2, $a2		#
		move	$s3, $a2		#

dooa:		rem	$t0, $s0, $s1		# digit = n % b
		div	$s0, $s1		# n = n/b
		mflo	$s0			#
		move	$a0, $t0		#
		jal 	toascii			#
		sb	$v0, 0($s3)		# *p++ = toascii( digit )
		addi	$s3, $s3, 1		#

whileoa:	bgt	$s0, 0, dooa		#
		sb	$0, 0($s3)		#  *p = '\0'
		move	$a0, $s2		#
		jal	strrev			#	strrev(s)
		lw	$ra, 0($sp)		#
		lw	$s0, 4($sp)		#
		lw	$s1, 8($sp)		#
		lw	$s2, 12($sp)		#
		lw	$s3, 16($sp)		# devolver os valores de $ra e $s
		addiu	$sp, $sp, 20		# restaurar o stack
		jr	$ra			# fim da função
		
		
		
##### STRREV #######

strrev:
		addiu	$sp, $sp, -16
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw	$s2, 12($sp)
		move	$s0, $a0
		move	$s1, $a0
		move	$s2, $a0
		
while1: 	lb	$t1, 0($s2)		#	$t1 = *p2;
		beq	$t1, '\0', endw1	# 	while( *p2 != '\0' ) {
		addiu	$s2, $s2, 1 		# 		p2++;
		j 	while1 			# 	}
endw1:		addiu	$s2, $s2, -1
while2:		bge	$s1, $s2, endw2
		move	$a0, $s1
		move	$a1, $s2
		jal 	exchange
		addi	$s1, $s1, 1
		addi	$s2, $s2, -1
		j	while2
endw2:		move	$v0, $s0
		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw	$s2, 12($sp)
		addiu	$sp, $sp, 16
		jr	$ra
		
		
######### EXCHANGE ###########		
		
exchange:					# void cxchange(char *c1, char *c2) {
		lb	$t0, 0($a0)		#	$t0 = *c1:
		lb	$t1, 0($a1)		#	$t1 = *c2;
		sb	$t0, 0($a1)
		sb	$t1, 0($a0)
		jr	$ra			# } fim do programa
		
