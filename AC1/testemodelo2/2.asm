# Mapa de Registos

# f1: $s0
# k: $s1
# av: $s2
# i: $s3
# res: $t2


	.data
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv SIZE, 15
str1:	.asciiz "Invalid argc"
	.text
	.globl func2

func2:		
		addiu		$sp, $sp, -20		# reserva espaço na stack
		sw		$ra, 0($sp)		# guarda valor de $ra
		sw		$s0, 4($sp)		# 
		sw		$s1, 8($sp)		# 
		sw		$s2, 12($sp)		# 
		sw		$s3, 16($sp)		# guarda valor dos $sx
		
		move		$s0, $a0		#
		move		$s1, $a1		#
		move		$s2, $a2		#
		
if:		blt		$s1, 2, else		#
		bgt		$s1, SIZE, else		# if( (k >= 2) && (k <= SIZE) ){
		li		$s3, 2			# 	i = 2;
do:		
							  	do{
		addu		$t3, $s3, $s2		#
		sw		$a0, 0($t3)
		jal		toi			# 		toi(av[i])
		sll		$t0, $s3, 2		#
		addu		$t1, $t0, $s0		#
		sw		$v0, 0($t1)		# 		f1[i] = toi(av[i])
		addi		$s3, $s3, 1		# 		i++;

while:		blt		$s3, $s1, do		#	}while(i < k)
		
		move		$a0, $s0		#
		move		$a1, $s1		#
		jal		avz			# 	avz(f1, k)
		move		$t2, $v0		#
		move		$a0, $t2		#
		li		$v0, print_int10	#
		syscall					#	print_int10(res)
							#	}
else:		la		$a0, str1		#
		li		$v0, print_string	#
		syscall					#     print_string("Invalid argc")

end		lw		$ra, 0($sp)		#
		lw		$s0, 4($sp)		#
		lw		$s1, 8($sp)		#
		lw		$s2, 12($sp)		#	
		lw		$s3, 16($sp)		#
		addiu		$sp, $sp, 20		#
		move		$v0, $t2		#
		jr		$ra			#  return 0