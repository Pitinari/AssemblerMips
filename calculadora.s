.data
ing: .asciiz "Ingrese un numero: "
nl: .asciiz "\n"
numero: .word 0

.text

main:

li $v0, 4
la $a0, ing
syscall

li $v0, 6
syscall

swc1 $f0, numero

lw $t0, numero

andi $t0, $t0, 8388607 	# equivalente a 0x007fffff

move $a0,$t0                 # put number into correct reg for syscall
li $v0,34                  # syscall number for "print hex"
syscall       