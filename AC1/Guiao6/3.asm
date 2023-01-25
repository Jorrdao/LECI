# Mapa de Registos
# $t0 - array
# $t1 - i
# $t2 - i temp
# $t3 - array + i
# $t4 - array[i]
# $t5 - j
# $t6 - array[i][j]
	
	.data
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz "ponteiros"
str4:	.asciiz "\nString #"
str5:	.asciiz ": "
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv print_char, 11
array:	.word str1, str2, str3 
	.text 
	.globl main
	
	
	
main:	la	$t0, array		 #  $t0 = array
	li	$t1, 0			 #  i = 0
	
while:	bge	$t1, SIZE, end		 #  (while i < SIZE){
	sll	$t2, $t1, 2		 #	i = i*4
	addu	$t3, $t2, $t0		 #	$t3 = &array[i]
	lw	$t4, 0($t3)		 #	$t4 = array[i]
	la	$a0, str4		 #
	li	$v0, print_string	 #	print_string(str4)
	syscall				 #
	ori	$a0, $t1, 0		 #	
	li	$v0, print_int10	 #	print_int10(i)
	syscall				 #
	la	$a0, str5		 #
	li	$v0, print_string	 #	print_string(str5)
	syscall				 #
	li	$t5, 0			 #	j = 0
	lb	$t6, 0 ($t4)		 #      array[i][j]
	
while2: beq	$t6, '\0', endw2	 # 	(while array[i][j] != '\0'){
	ori	$a0, $t6, 0		 #
	li	$v0, print_char		 #           print_char(array[i][j])
	syscall				 #
	li	$a0, '-'		 #		
	li	$v0, print_char		 #	     print_char(-)
	syscall
	addi	$t5, $t5, 1		 #           j++
	addu	$t7, $t5, $t4		 #
	lb	$t6, 0 ($t7)		 #
	j	while2			 #   	}
	
endw2:	addi	$t1, $t1, 1		 #
	j 	while			 #
	
end:	jr	$ra			 # fim do programa
	