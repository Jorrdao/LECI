	# Mapa de Registos

# rv : $t7
# n : $t4
# sum : $t1
# nit : $t2
# pt : $t0	
# lista + Size : $t3


	.data
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv read_int, 5
	.eqv SIZE, 8
list:	.space 32

str1:	.asciiz "Media invalida\n"
	.text
	.globl main


main:		la 	$t0, list		#  
		li	$t3, SIZE		#
		sll	$t3, $t3, 2		#
		addu	$t3, $t3, $t0		#
		li 	$t1, 0			#  int sum = 0;
		li	$t2, 0			#  int nit = 0;

for1:		bge	$t0, $t3, endfor1	#  for(pt = list; pt < (list + size); pt++){
		li	$v0, read_int		#
		syscall
		sw	$v0, 0($t0)		#   *pt = read_int()
		addi	$t0, $t0, 4		#
		j	for1			#  }
	
endfor1:	li	$t4, 0			#  int n = 0
		la 	$t0, list		#

for2:		bge	$t4, SIZE, if2		#  for(n=0; n < SIZE; n++){
		sll	$t5, $t4, 2		#
		addu	$t5, $t0, $t5		#
		lw	$t6, 0($t5)		#

if1:		blt	$t6, 0, endif1		#     if(list[n] >= 0){
		addu	$t1, $t6, $t1		#		sum += list[n]
		addi	$t2, $t2, 1		#		nit++;

endif1:		addi	$t4, $t4, 1		#
		j	for2			# }  	

if2:		ble	$t2, 0, else2		# if(nit > 0){
		div	$a0, $t1, $t2		#
		li	$v0, print_int10	#	print_int10(sum/nit)
		syscall
		li	$t7, 0			#	rv = 0
		j	end

else2:		la	$a0, str1		# else{
		li	$v0, print_string	#
		syscall				#	print_string(\n Media Invalida!\n)
		li	$t7, -1			#	rv = -1
						# }
end:		li	$v0, 0			#
		jr	$ra			# return 0;
	