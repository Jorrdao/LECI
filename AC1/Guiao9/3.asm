	.data
	.eqv SIZE, 10
	.eqv read_int, 5
	.eqv print_double, 3
	.align 3
a:	.space 80
k0:	.double 0.0
	.text
	.globl main
	
# Mapa de Registos
# $t0 = SIZE * 8
# $t1 = i
# $t2 = a
# $t3 = array[max]
# $t4 = i*8
# $t5 = SIZE*8
	


average:	
		la	$t1, k0
		l.d	$f0, 0($t1)
		move	$t0, $a0
		move	$t1, $a1
		
for:		ble	$t1, 0, endfor
		addi	$t2, $t1, -1
		sll	$t2, $t2, 3
		addu	$t3, $t0, $t2
		l.d	$f6, 0($t3)
		add.d	$f0, $f0, $f6
		addi	$t1, $t1, -1
		j for
		
endfor:		mtc1	$a1, $f4
		cvt.d.w	$f4, $f4
		div.d	$f0, $f0, $f4
		jr	$ra
		
		
		
		
		
main:		addiu	$sp, $sp, -4		#  libertar espaço na stack
		sw	$ra, 0($sp)
		li	$t1, 0			#  i = 0
		la	$t2, a			#  $t2 = &array(0)
		 
		
for1:		bge	$t1, SIZE, endfor1 	# for(i = 0; i < size, i++){
		addu	$t5, $t2, $t4		#
		li	$v0, read_int		#
		syscall				#  read_int()
		mtc1	$v0, $f2		#
		cvt.d.w $f2, $f2		# double(read_int())
		s.d	$f2, 0($t5)		# a = double(read_int())
		addi	$t1, $t1, 1		#
		sll	$t4, $t1, 3		# 
		j	for1			# }

endfor1:	la	$a0, a			#
		li	$a1, SIZE		#
		jal	average			#
		mov.d	$f12, $f0
		li	$v0, print_double	# 
		syscall				# print_double(average)
		lw	$ra, 0($sp)		# report $ra
		addiu	$sp, $sp, 4		# repor stack
		jr	$ra			#
