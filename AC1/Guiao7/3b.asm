# Mapa de Registos
#
#
#

	.data
	.eqv	STR_MAX_SIZE, 20
	.eqv	print_string, 4
	.eqv	print_int10, 1
str1:	.asciiz	"I serodatupmoC" #ed arutetiuqrA"
str2:	.space	STR_MAX_SIZE
str3:	.asciiz "\n"
str4:	.asciiz "String too long: "
	.text 
	.globl main

# Main	
	
main:		addiu	$sp, $sp, -4		#
		sw	$ra, 0($sp)		#
		la	$a0, str1		#
		jal	strlen			#     strlen(str1)

if:		bgt	$v0, STR_MAX_SIZE, else #   if (strlen(str1) <= STR_MAX_SIZE){
		la	$a1, str1		#
		la	$a0, str2		#
		jal	strcopy			#   strcopy(str2,str1)
		move	$a0, $v0		#
		li	$v0, print_string	#
		syscall				#   print_string(str2)
		la	$a0, str3		#
		li	$v0, print_string
		syscall				#   print_string("\n") 	
		la	$a0, str2		#
		jal	strrev			#
		move	$a0, $v0		#
		li	$v0, print_string	#   
		syscall				#   print_string(strrev(str2))
		li	$v0, 0			#   return 0
		j	end			#   }

else:		la	$a0, str4		#
		li	$v0, print_string	#   
		syscall				#   print_string("string to long: ")
		la	$a0, str1		#
		jal	strlen			#
		move	$a0, $v0		#
		li	$v0, print_int10	#  
		syscall				#   print_int10(strlen(str1))
		li	$v0, -1			#  return -1;
		
end:		lw	$ra, 0($sp)		#
		addiu	$sp, $sp, +4		#
		jr	$ra			# fim do programa	
		
					


# Funções

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

#
	
strlen:	
	li	$t1, 0			#	len = 0
while3:	lb	$t0, 0($a0)		#	while($t0 != '\0'){    
	addiu	$a0, $a0, 1		#		 $t0 = *s
	beq	$t0, '\0', endw 	#		 *s++	
	addi	$t1, $t1, 1		#		 len++
	j	while3			#	}
	
endw:	move	$v0, $t1		#	
	jr	$ra			#	return len
	
#	
	
strcopy:
			
		move	$t1, $a0	# $t1 = &(dst)	
do:		lb	$t2, 0($a1)	# 
		sb	$t2, 0($a0)	# 	dst[i] = src[i]
		addiu	$a1, $a1, 1	# do{	$a1 = src[i]	
		addiu	$a0, $a0, 1	# 	$a0 = dst[i]
while:		bne	$t2, '\0', do   # }while(src[i++] != '\0')
end1:		move	$v0, $t1	#
		jr	$ra		# devolve o endereço de dst
		
#		
		
exchange:					# void cxchange(char *c1, char *c2) {
		lb	$t0, 0($a0)		#	$t0 = *c1:
		lb	$t1, 0($a1)		#	$t1 = *c2;
		sb	$t0, 0($a1)
		sb	$t1, 0($a0)
		jr	$ra			# } fim do programa
		
