      .data 
str1: .asciiz "Introduza 2 numeros\n" 
str2: .asciiz "A soma dos dois numeros e': "  
      .eqv  print_string,4  
      .eqv  read_int,5 
      .eqv  print_int10,1 

      .text  	
      .globl main 
main: la $a0,str1  
      ori $v0,$0,print_string 
      syscall   			# print_string(str1); 
      ori $v0,$0,read_int 
      syscall
      or $t0,$0,$v0
      ori $v0,$0,read_int
      syscall
      or $t1,$0,$v0
      add $t2,$t1,$t0
      la $a0,str2
      ori $v0,$0,print_string
      syscall
      move $a0,$t2
      ori $v0,$0,print_int10
      syscall
      
      
     		# valor lido e' retornado em $v0  or $t0,$v0,$0  # $t0=read_int() 
      jr $ra  	 			# fim do programa 
