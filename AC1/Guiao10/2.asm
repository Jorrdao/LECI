	.data
	.eqv print_double, 3
	.eqv print_string, 4
	.eqv read_double, 7
str1:	.asciiz "Introduza um número real: "
str2:	.asciiz "\n Raiz quadrada: "
k0:	.double 1.0
k1:	.double 0.5
k2:	.double 0.0
	.text
	.globl main
	

main:	addiu	$sp, $sp, -4		# reservar espaço na stack
	sw	$ra, 0($sp)		#
	la	$a0, str1		#
	li	$v0, print_string	#
	syscall				# print_string(Introduza um numero real)
	li	$v0, read_double	#
	syscall				# read_double()
	mov.d	$f12, $f0		#
	jal	sqrt			#
	la	$a0, str2		#
	li	$v0, print_string	#
	syscall				# print_string(Raiz quadrada: )
	mov.d	$f12, $f0		#
	li	$v0, print_double	#
	syscall				# print_double (sqrt)

end:	lw	$ra, 0($sp)		# devolve o valor de $ra
	li	$v0, 0			#
	addiu	$sp, $sp, 4		# return 0;
	jr      $ra
	


####### sqrt #######

# Mapa de Registos
# $f2 = aux
# $f4 = xn
# $f6 = val
# $f8 = aux2
# $f10 = 0.5
# $t0 = i

sqrt:	
	li	$t0, 0		# int i = 0
	la	$t1, k0
	l.d	$f2, 0($t1)	# 
	l.d	$f4, 0($t1)	# double aux, xn = 1.0
	la	$t1, k1		#
	l.d	$f10, 0($t1)	# k = 0.5
	la	$t1, k2		#
	l.d	$f18, 0($t1)	# k = 0.0
	mov.d	$f6, $f12	#
	la	$t2, k1		#
	
	
	
if1:	c.le.d	$f6, $f18	#
	bc1t	else1		# if (val > 0){
	
do1:	mov.d	$f2, $f4	#  do{	aux = xn
	div.d	$f8, $f6, $f4	# 	aux2 = val/xn
	add.d	$f8, $f8, $f4	# 	aux2 = xn + val/xn
	mul.d	$f4, $f8, $f10	# 	xn = aux2 * 0.5
	addi	$t0, $t0, 1	#	i++;
	
while1:	c.eq.d	$f2, $f4	#
	bc1f	do1		#
	blt	$t0, 26, do1	#  }while((aux != xn) & (++i < 25))
	j	end1		# }
	
else1:	mov.d	$f4, $f18	#

end1:	mov.d	$f0, $f4	#
	jr	$ra		# return 0;
	
