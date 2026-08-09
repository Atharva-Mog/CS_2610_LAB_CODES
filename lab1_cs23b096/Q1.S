.section .data # Data section
num1: .word 5 
num2: .word 3 
num3: .word 4
num4: .word 6
num5: .word 5

.section .text # Code section
.globl main 

main:

la t0,num1 
li t1,0
li t6,5
loop:   lw t5,0(t0)
        add t2,t5,t1
        sw t2,0(t0)
        addi t0,t0,4
        addi t1,t1,1
        bgt t6,t1,loop

li a7, 93 # Load ecall number for exit into a7
ecall 

