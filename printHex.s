.data
prompt1: .asciiz "Enter an integer number: "
answer: .space 9
.text
.globl main

main:
        la $a0, prompt1     #prompt user for integer
        li $v0, 4
        syscall

        la $a1, answer      # load the address of answer into $a1

        li $v0, 5       #allow for input of integer
        syscall
        add $a0, $v0, $0 #add the input to the $a0 register
        jal print_hex

        la $a0, answer
        li $v0, 4
        syscall         #print out hex answer to console

	li $v0, 10
	syscall

        j main


print_hex:
        andi $t0, $a0, 15
        addi $a1, $a1, 1

        ble $t0, 10, lessThanTen        
        addi $t0, $t0, 39   
    lessThanTen:
        addi $t0, $t0, 48
        sb $t0, 0($a1)
        srl $a0, $a0, 4
        bne $a0, $0, print_hex
    done:
        jr $ra