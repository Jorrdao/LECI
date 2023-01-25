# Mapa de Registos

# $t0 = i
# $a0 = &(dst)+i
# $a1 = &(src)+i
# $t1 = &(dst)
# $t2 = aux
# $t3 = src[i++]

strcopy:
		li	$t0, 0		# i = 0		
		move	$t1, $a0	# $t1 = &(dst)	
do:		addu	$a1, $a1, $t0	# do{	$a1 = src[i]	
		addu	$a0, $a0, $t0	# 	$a0 = dst[i]
		lb	$t2, 0($a1)	# 
		sb	$t2, 0($a0)	# 	dst[i] = src[i]
		addi	$t0, $t0, 1	# 	i++
		sb	$t3, 4($a1)	#
while:		bne	$t3, '\0', do   # }while(src[i++] != '\0')
end:		move	$v0, $t1	#
		jr	$ra		# devolve o endereço de dst
		