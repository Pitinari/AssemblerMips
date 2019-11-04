.data
ing: .asciiz "Ingrese un numero: "
nl: .asciiz "\n"
numCompletoMsg: .asciiz "El numero en Hexa: "
numCompleto: .asciiz "0x00000000"
mantisaMsg: .asciiz "La mantisa en Hexa: "
mantisa: .asciiz "0x000000"
exponenteMsg: .asciiz "El exponente en exceso, en Hexa: "
exponente: .asciiz "0x00"
signoMsg: .asciiz "El signo en Hexa: "
signo: .asciiz "0x0"


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

move $a0, $t0
la $a1, numCompleto
addi $a1, $a1, 9
jal print_hex

li $v0, 4
la $a0, numCompleto
syscall

li $v0, 4
la $a0, nl
syscall

lw $t0, numero

li $t1, 0x7fffff
and $a0, $t0, $t1
la $a1, mantisa
addi $a1, $a1, 7
jal print_hex

li $v0, 4
la $a0, mantisaMsg
syscall

li $v0, 4
la $a0, mantisa
syscall

li $v0, 4
la $a0, nl
syscall

lw $t0, numero

li $t1, 0x7f800000
and $a0, $t0, $t1
srl $a0, $a0, 23
la $a1, exponente
addi $a1, $a1, 3
jal print_hex

li $v0, 4
la $a0, exponenteMsg
syscall

li $v0, 4
la $a0, exponente
syscall

li $v0, 4
la $a0, nl
syscall

lw $t0, numero

li $t1, 0x80000000
and $a0, $t0, $t1
srl $a0, $a0, 31
la $a1, signo
addi $a1, $a1, 2
jal print_hex

li $v0, 4
la $a0, signoMsg
syscall

li $v0, 4
la $a0, signo
syscall

li $v0, 4
la $a0, nl
syscall

li $v0, 10
syscall

print_hex:
        andi $t0, $a0, 0xf

        ble $t0, 9, menorA10        
        addi $t0, $t0, 39   
    menorA10:
        addi $t0, $t0, 48
        sb $t0, 0($a1)
        srl $a0, $a0, 4
	addi $a1, $a1, -1
        bne $a0, $0, print_hex
    fin:
        jr $ra
