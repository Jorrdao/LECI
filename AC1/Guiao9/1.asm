	.data
	.eqv print_float, 2
	.eqv read_int, 5
	.eqv print_string, 4
k0:	.asciiz "\n"
k1:	.float 2.5935
k2:	.float 0.0
	.text
	.globl main
	
main:	
	
do:	li		$v0, read_int	 # do{
	syscall				 #  val = read_int()
	la		$t0, k1		 #
	l.s		$f4, 0($t0)	 #
	mtc1		$v0, $f6	 #  move to coprocessor
	cvt.s.w		$f6, $f6	 #  float(val)
	mul.s		$f12, $f6, $f4	 #  res = val * k1
	li		$v0, print_float # 
	syscall				 #  print_float(res)
	la		$a0, k0		 #
	li		$v0, print_string#
	syscall				 #  print_string( "\n")

while:	la		$t0, k2		 #
	l.s		$f8, 0($t0)	 #
	c.eq.s		$f6, $f8	 # condition
	bc1f		do		 #

end:	li		$v0, 0		 #
	jr		$ra		 #
	
	