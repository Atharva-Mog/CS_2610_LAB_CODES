.section .data # Data section  
num1: .dword 6
num2: .dword 4
res1: .dword 0
res2: .dword 0
res3: .dword 0
res4: .dword 0
res5: .dword 0

.section .text
.global main

main:

la t0,num1
la t1,num2

lw t2,0(t0)
lw t3,0(t1)

add t4,t2,t3
la t5,res1
sw t4,0(t5)

sub t4,t2,t3
la t5,res2
sw t4,0(t5)

and t4,t2,t3
la t5,res3
sw t4,0(t5)

or t4,t2,t3
la t5,res4
sw t4,0(t5)

xor t4,t2,t3
la t5,res5
sw t4,0(t5)


li a7, 93 # Load ecall number for exit into a7
ecall 