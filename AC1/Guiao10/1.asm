	.data
	.eqv print_float, 2
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv read_float, 6
k0:	.float 1.0
str1:	.asciiz "Introduza um número inteiro: "
str2:	.asciiz	"\nIntroduza um float: "
str3:	.asciiz "\nResultado: "
	.text
	.globl main

main:	addiu	$sp, $sp, -4		# 	poem espaco na pilha
	sw	$ra, 0($sp)		#	guarda o $ra
					#
	la	$a0, str1		#	$a0 = str1
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str1)
	li	$v0, read_double		#	$v0 = 7;
	syscall				#	read_double();
	mov.d	$f12, $f0		#	x = read_double();
					#
	la	$a0, str2		#	$a0 = str2
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str2)
	li	$v0, read_int		#	$v0 = 5;
	syscall				#	read_int();
	move	$a0, $v0			#	y = read_int();
	
	jal	xtoy			#	xtoy(x, y);
	mov.d 	$f12, $f0		#	result = return(xtoy(x, y));
	
	la	$a0, str3		#	$a0 = str3
	li	$v0, print_string	#	$v0 = 4
	syscall				#	print_string(str3)
	li	$v0, print_double	#
	syscall				#	print_double(result);
					#	
	lw	$ra, 0($sp)		#	repoem o valor de $ra
	addiu	$sp, $sp, 4		#	repoem o tamanho da pilha
	li	$v0, 0			#	return 0;
	jr	$ra			# }		# return 0		
	









	
######## xtoy #########		
	
xtoy:	
	addiu	$sp, $sp, -28		# 	poem espaco na pilha
	sw	$ra, 0($sp)		#	guarda o $ra
	sw	$s0, 4($sp)		#	guarda o $s0
	sw	$s1, 8($sp)		#	guarda o $s1
	s.d	$f20, 12($sp)		#	guarda o $f20
	s.d	$f22, 20($sp)		#	guarda o $f22
	
	li	$s0, 0			#	i = 0;
	la	$t0, x0			#	$t0 = &x0;
	l.d	$f20, 0($t0)		#	$f20 = res = 1.0;
	move	$s1, $a0			#	$s1 = y
	mov.d  	$f22, $f12		#	$f22 = x
	move	$a0, $s1
	jal	abss			#	abss(y);
	move	$t1, $v0			#	$t1 = return(abs(y))
for:	bge	$s0, $t1, endfor 	#	for(i = 0, result = 1.0; i < abs(y); i++) {
if:	ble	$s1, 0, else		#		if(y > 0) {
	mul.d	$f20, $f20, $f22		#			result *= x;
	j	endif			#			
else:					#		else {
	div.d	$f20, $f20, $f22		#			result /= x;
endif:					#		}
	addi	$s0, $s0, 1		#		i++;
	j	for			#	}
endfor:					#
	mov.d	$f0, $f20		#	return result;
	lw	$ra, 0($sp)		#	repoem o valor de $ra
	lw	$s0, 4($sp)		#	repoem o $s0
	lw	$s1, 8($sp)		#	repoem o $s1
	l.d	$f20, 12($sp)		#	repoem o $f20
	l.d	$f22, 20($sp)		#	repoem 0 $f22
	addiu	$sp, $sp, 28		#	repoem o tamnhao da pilha

	jr	$ra			# } fim do programa
	
	
######## abs #############

abss:	
	move	$v0, $a0
for2:	bge	$v0, 0, endfor2
	mul	$v0, $v0, -1
	
endfor2:jr	$ra
	

	
	