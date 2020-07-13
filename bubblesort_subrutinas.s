.data

lista: .word 0,5,4,24,7,3,4,9,1
largo_lista: .word 9
espacio: .asciiz " "
aviso_sinord: .asciiz "desordenado: "
aviso_ord: .asciiz "\nordenado: "

.text

main:

jal bubbleSort

li $v0, 10 
syscall

####

bubbleSort:

li $v0, 4
la $a0, aviso_sinord
syscall

la $t0, lista	#lista
lw $s0, largo_lista	#i
lw $s2, largo_lista	#h

for_mostrar_desord:
beq $s2, 0, for_i

li $v0, 1
lw $a0, 0($t0)
syscall

li $v0, 4
la $a0, espacio
syscall	

addi $t0, $t0, 4
addi $s2, $s2, -1

j for_mostrar_desord

####

for_i:
beq $s0, 0, imprimir_ord
li $s1, 1 #j
la $t0, lista

for_j:
beq $s1, $s0, fin_for_i
lw $t1, ($t0)
addi $t0, $t0, 4
lw $t2, ($t0)

bgt $t1, $t2, intercambiar
j fin_for_j

intercambiar:
sw $t1, ($t0)
addi $t0, $t0, -4
sw $t2, ($t0)
addi $t0, $t0, 4

fin_for_j:
addi $s1, $s1, 1
j for_j

fin_for_i:
addi $s0, $s0, -1
j for_i

####

imprimir_ord:
lw $s0, largo_lista
la $t0, lista

li $v0, 4
la $a0, aviso_ord
syscall

for_ord:
beq $s0, 0, fin_bubbleSort

li $v0, 1
lw $a0, 0($t0)
syscall

li $v0, 4
la $a0, espacio
syscall

addi $t0, $t0, 4
addi $s0, $s0, -1
j for_ord

fin_bubbleSort:
jr $ra
