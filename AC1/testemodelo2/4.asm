# Struct			Align	Size	Offset
 
# int acc			4	4	0
#
# unsigned char nm		1	1	4
#
# double grade			8	8	8
#
# char quest[14]		1	14	16
#
# int cq;			4	4	32
#
# t_kvd				4	36



# Mapa de Registos
# nv: $t0
# pt: $t1
# i:  $t2
# j:  $t3
# sum:$f2



	.data
k0:	.double 0.0
	.text
	.globl func4


func4:		la		$t0, k0		
		l.d		$f2, 0($t0)
		move		$t0, $a0
		move		$t1, $a1
		li		$t2, 0
		
for:		bge		$t2, $t0, endfor
		li		$t3, 0

do:		addiu		$t4, $t1, 16	
		addu		$t4, $t4, $t3
		lb		$t4, 0($t4)
		
		mtc1		$t4, $f4
		cvt.d.w		$f4, $f4
		add.d		$f2, $f2, $f4
		
		addi		$t3, $t3, 1

		
		lbu		$t4, 4($t1)

while:		blt		$t3, $t4, do
		
		l.d		$f4, 8($t1)
		div.d		$f6, $f2, $f4
		cvt.w.d	$f6, $f6
		mfc1		$t4, $f6
		sw		$t4, 0($t1)

		addi		$t2, $t2, 1

end:		lw		$t5, 32($t1)
		mtc1		$f8, $t5
		cvt.d.w	$f8, $f8
		mul.d		$f0, $f8, $f4
		jr		$ra
