	.data
	.eqv print_float
	.eqv read_int
k1:	.float 2.5935
k2:	.float 0.0
	.text
	.globl main
	
main:	
do:	li	$v0, read_int
	syscall	
	move	$t0, $v0
	l.s	$f2, k1
	mtc1	$t0, $f0
	cvt.s.w	$f0, $f0
	mul.s	$f2, $f2, $f0
	mov.s	$f12, $f2
	li	$v0, print_float
	syscall
	l.s	$f4, k2
	c.eq.s	$f4, $f2
	bc1t	end
	j	do
	
end:	li	$v0, 0
	jr	$ra