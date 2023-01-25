# Mapa de Registos

# a: $a0
# t: $f2
# n: $t0
# oldg: $f4
# g: $f6
# s: $f8
# k: $t1

	.data
k0:	.float -1.0
k1:	.float 1.0
k2:	.float 0.0
	.text
	.globl func3


func3:
		la		$t0, k0			#
		l.s		$f4, 0($t0)		#	oldg = -1.0
							#
		la		$t0, k1			#
		l.s		$f6, 0($t0)		#	g = 1.0
							#
		la		$t0, k2			#
		l.s		$f8, 0($t0)		#	s = 0.0
							#
		li		$t1, 0			#	k = 0
							#
							#
for:		bge		$t1, $t0, end		#	for(k = 0; k <n; k++){
		sub.s		$f10, $f6, $f4		#		

while:		c.le.s 		$f10, $f2		#
		bc1t		endwhile		# 		while( ( g - oldg) > t){
		mov.s		$f4, $f6		#			oldg = g;
		sll		$t2, $t1, 2		#			
		addu		$t2, $a0, $t2		#
		l.s		$f12, 0($t2)		#
		add.s		$f12, $f12, $f6		#			g + a[k]
		div.s		$f6, $f12, $f2		#			g = (g + a[k])/t
		j		while			#		}

endwhile:	add.s		$f8, $f8, $f6		#		s = s + g
		s.s		$f6,	0($t2)		#		a[k] = g
		addi		$t1, $t1, 1		#
		j		for			#	}

end:		mtc1		$t0, $f0		#
		cvt.s.w	$f0, $f0			#
		div.s		$f0, $f8, $f0		#
		jr		$ra		