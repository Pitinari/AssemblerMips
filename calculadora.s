.data
ing: .asciiz "Ingrese un numero: "
numCompletoMsg: .asciiz "El numero en Hexa: "
numCompleto: .asciiz "0x00000000"
mantisaMsg: .asciiz "La mantisa en Hexa: "
mantisa: .asciiz "0x000000"
exponenteExcesoMsg: .asciiz "El exponente en exceso, en Hexa: "
exponenteExceso: .asciiz "0x00"
exponenteMsg: .asciiz "El exponente sin exceso (complemento a dos), en Hexa: "
exponente: .asciiz "0x00000000"
signoMsg: .asciiz "El signo en Hexa: "
signo: .asciiz "0x0"


numero: .word 0

.text


lw $t0, numero

main:

li $v0, 4
la $a0, ing
syscall

li $v0, 6 #ingreso del numero flotante
syscall

swc1 $f0, numero #cargo en la memoria el numero expresado como flotante
lw $s0, numero #y lo bajo como entero

move $a0, $s0   #cargo como primer parametro $t0
la $a1, numCompleto #cargo la direccion de memoria de numCompleto para editar el string y luego printearlo
addi $a1, $a1, 9  #avanzo 9 bytes en el string para arrancar del inicio al final y poder imprimir en orden
jal print_hex

li $v0, 4
la $a0, numCompletoMsg #mensaje previo
syscall

li $v0, 4
la $a0, numCompleto #printeo el numero completo en hexa
syscall

li $v0, 11
li $a0, 10  #salto de linea
syscall

li $t1, 0x7fffff
and $a0, $s0, $t1 #cargo en el parametro $a0 el and de 0x7fffff que es equivalente al retorno de los primeros 23 bits (mantisa)
la $a1, mantisa #segundo parametro la direccion de memoria de el string de la mantisa
addi $a1, $a1, 7  #avanzo 7 bytes para iniciar del final del string
jal print_hex

li $v0, 4
la $a0, mantisaMsg  #mensaje previo
syscall

li $v0, 4
la $a0, mantisa #printeo mantisa
syscall

li $v0, 11
li $a0, 10  #salto de linea
syscall

li $t1, 0x7f800000
and $a0, $s0, $t1 #cargo en el parametro $a0 el and de 0x7f800000 que es equivalente al retorno de los 8 bit del exponente
srl $a0, $a0, 23  #muevo hacia la "derecha" 23 bits (los equivalentes a la mantisa), para tener el numero completo del exponente
la $a1, exponenteExceso #segundo parametro la direccion de memoria del string del exponente
addi $a1, $a1, 3  #avanzo 3 bytes para iniciar del final del string
jal print_hex

li $v0, 4
la $a0, exponenteExcesoMsg #mensaje previo
syscall

li $v0, 4
la $a0, exponenteExceso #printeo exponente
syscall

li $v0, 11
li $a0, 10  #salto de linea
syscall

li $t1, 0x7f800000
and $a0, $s0, $t1 #cargo en el parametro $a0 el and de 0x7f800000 que es equivalente al retorno de los 8 bit del exponente
srl $a0, $a0, 23  #muevo hacia la "derecha" 23 bits (los equivalentes a la mantisa), para tener el numero completo del exponente
sub $a0, $a0, 127 #le resto el exceso
la $a1, exponente #segundo parametro la direccion de memoria del string del exponente
addi $a1, $a1, 9  #avanzo 3 bytes para iniciar del final del string
jal print_hex

li $v0, 4
la $a0, exponenteMsg #mensaje previo
syscall

li $v0, 4
la $a0, exponente #printeo exponente
syscall

li $v0, 11
li $a0, 10  #salto de linea
syscall

move $a0, $s0 #cargo en el parametro $a0 el numero
srl $a0, $a0, 31  #y muevo hacia la "derecha" 31 bits, para que me quede solo el bit del signo
la $a1, signo #segundo parametro la direccion de memoria del string del signo
addi $a1, $a1, 2 #y avanzo 2 bytes para arrancar del ginal del string
jal print_hex

li $v0, 4
la $a0, signoMsg  #mensaje previo
syscall

li $v0, 4
la $a0, signo #printeo signo
syscall

li $v0, 10  #fin del programa
syscall

print_hex:  #funcion para cargar en la memoria, pasada por $a1, el numero entero, pasado por $a0, en hexadecimal
        andi $t2, $a0, 0xf  #cargo en $t2 los primeros 4 bits de $a0

        ble $t2, 9, menorA10  #si el equivalente entero de los 4 bits es menor a 10 (menor o igual a 9), entonces no le sumo 39 para que su equivalente en ascii sea un alfabetico, sino que sea un caracter numerico, mas precisamente el caracter equivalente al valor que tiene es ese momento
        addi $t2, $t2, 39
    menorA10:
        addi $t2, $t2, 48 #le sumo 48 para que llegue a los caracteres alfanumericos en la tabla ascii
        sb $t2, 0($a1)  #guardo en $a1 el byte con el equivalente alfanumerico en hexa de $t2
        srl $a0, $a0, 4 #muevo hacia la "derecha" 4 bits del numero
	      addi $a1, $a1, -1  #resto una posicion a la direccion de memoria del parametro $a1, que vendria a ser el string con el equivalente en hexa de $a0
        bne $a0, $0, print_hex  #si el numero no es 0 sigo el loop
    fin:
        jr $ra
