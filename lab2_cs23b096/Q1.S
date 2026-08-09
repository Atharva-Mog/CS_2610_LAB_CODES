.section .data

val0: .word 0
val1 : .word 1
result : .word 0
arr: .word 0
.section .text

.globl main

main:

li a0,5

jal ra,fib

li t4,0
li t5,0
li t6,5

loop:   beq t5,t6,end
        addi t5,t5,1
        mv a0,t5
        jal ra,fib
        add t4,t4,a0

        j loop


mv a0,t4
end:
li a7,93
ecall

fib:

add sp,sp,-40

sd ra,32(sp)
sd s0,24(sp)

addi s0,sp,40

sw a0,-20(s0)

li t1,1

beq a0,t1,one
beqz a0,z

mv  a4,a0
addi a5,a4,-1
addi a6,a4,-2

sw a5,-24(s0)
sw a6,-28(s0)

lw a0,-24(s0)
jal ra,fib
mv  s1,a0
sw s1,-32(s0)

lw a0,-28(s0)
jal ra,fib
mv  s2,a0
sw s2,-36(s0)

lw a2,-32(s0)
lw a3,-36(s0)
add a0,a2,a3
la t0,arr
lw a4,-20(s0)
slli a4,a4,4
add t0,t0,a4
sw a0,0(t0)

ld ra,32(sp)
ld s0,24(sp)
addi sp,sp,40

ret

one:

la t0,arr
addi t0,t0,4

sw a0,0(t0)
mv a0,t1
sw a0,0(t0)
ld ra,32(sp)
ld s0,24(sp)
addi sp,sp,40

ret

z:

la t0,arr
mv a0,x0
sw a0,0(t0)
ld ra,32(sp)
ld s0,24(sp)
addi sp,sp,40

ret

















