# Mapa de Registos
# $a0, $s0 = n
# $a1, $s1 = b
# $a2, $s2 = s
# $s3 = p
# $t0 = digit

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

do:		rem	$t0, $s0, $s1		# digit = n % b
		div	$s0, $s1		# n = n/b
		mflo	$s0			#
		move	$a0, $t0		#
		jal 	toascii			#
		sb	$v0, 0($s3)		# *p++ = toascii( digit )
		addi	$s3, $s3, 1		#

while:		bgt	$s0, 0, do		#
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
		
		
	
		