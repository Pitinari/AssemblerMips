##### fibonacci #####

.data
msg: .asciiz "Ingrese el limite: "
espacio: .asciiz " "

.text

main: 

li $s0, 0
li $s1, 1

li $v0, 4
la $a0, msg
syscall

li $v0, 5
syscall

move $t0, $v0
addi $t0, $t0, -1

li $v0, 1
move $a0, $s0
syscall

fibo:
beq $t0, $0, fin

li $v0, 1
move $a0, $s1
syscall

li $v0, 4
la $a0, espacio
syscall

move $s3, $s1
add $s1, $s1, $s0
move $s0, $s3

addi $t0, $t0, -1

j fibo

fin:
li $v0, 10
syscall