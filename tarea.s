.data

msg1: .asciiz ".1 Muestro 'Pato'\n.2 Muestro 'Adivina Adivinador'\n.3 Termino el programa\nQue opcion elige? "

resp1: .asciiz "Pato\n"

resp2: .asciiz "Adivina Adivinador\n"

resp3: .asciiz "Programa terminado\n"

resp4: .asciiz "Opcion incorrecta\n"



.text


opcion1:

li $v0, 4

la $a0, resp1

syscall

j end



opcion2:

li $v0, 4

la $a0, resp2

syscall

j end



opcion3:

li $v0, 4

la $a0, resp3

syscall


li $v0, 10

syscall



main:

li $v0, 4

la $a0, msg1

syscall


li $v0, 5

syscall


beq $v0, 1, opcion1


beq $v0, 2, opcion2


beq $v0, 3, opcion3
li $v0, 4

la $a0, resp4

syscall



end:

j main
