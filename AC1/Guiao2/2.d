	.data
	.text
	.globl main
main:	ori $t0,$0,2
	or  $t1,$0,$t0
	sra $t2,$t0,4
	xor $t0,$t2,$t0
	sra $t2,$t0,2
	xor $t0,$t2,$t0
	sra $t2,$t0,1
	xor $t0,$t2,$t0
	or  $t2,$0,$t0
	jr $ra