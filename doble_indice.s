.data

lista1: .word 1,-1,5,7
lista2: .word 2,4,6,8
largoListas: .word 4
espacio: .asciiz " "
saltoLinea: .asciiz "\n"

.text

main:

la $t0, lista1
la $t1, lista2
lw $s0, largoListas

mostrar:

beq $s0, 0, fin

li $v0, 1
lw $a0, ($t0)
syscall

li $v0, 4
la $a0, espacio
syscall

li $v0, 1
lw $a0, ($t1)
syscall

li $v0, 4
la $a0, saltoLinea
syscall 

addi $t0, $t0, 4
addi $t1, $t1, 4
addi $s0, $s0, -1

j mostrar

fin:
li $v0, 10
syscall
