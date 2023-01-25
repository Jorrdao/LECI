	.data
	.text
	.globl main
main:	ori $t0,$0,4
	sra $t1,$t0,1
	xor $t2,$t1,$t0
	jr $ra
	
	
	
