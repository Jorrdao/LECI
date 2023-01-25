# Mapa de Registos
# $v0 = res
# $a0 = s
# $t0 = *s
# $t1 = digit	
	
	
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