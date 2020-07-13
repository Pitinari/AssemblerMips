.data

msg: .asciiz "Ingrese un numero: "
lista: .word 0

.text

main:

la $t0, lista
la $t5, lista

ingresarNumeros:

li $v0, 4
la $a0, msg
syscall

li $v0, 5
syscall

addi $s0, $s0, 1

beq $v0, $0, loopSuma

sw $v0, ($t5)
addi $t5, $t5, 4

j ingresarNumeros

loopSuma:

beq $s0, 1, finSuma

lw $t1, ($t0)

add $t2, $t2, $t1
addi $t0, $t0, 4
addi $s0, $s0, -1

j loopSuma

finSuma:

li $v0, 1
move $a0, $t2
syscall

fin:

li $v0, 10
syscall

	