.section .text
.global main

main:

li t0,0x2004000     // to stores address of mtimecmp
li t1,10000   
sw t1,0(t0)


la t3,user_mode
csrw mepc,t3

csrr t0,mstatus
li t1, 0x1800
not t2,t1
and t0,t0,t2
csrw mstatus,t0


li t4,0x80
csrr t5,mie
or t5,t5,t4
csrw mie,t5
la t0,mtrap
csrw mtvec,t0

//li t0,0x200bff8     //mtime address

mret

.align 4
mtrap:

li t2,0x2004000
lw t3,0(t2)
li t4,10000        
add t3,t3,t4
sw t3,0(t2)

mret


user_mode: 

.align 4
   /*li t0,0x200bff8 
    lw t1,0(t0)
    addi t1,t1,1
    sw t1,0(t0)
    li t0,0x2004000 
    lw t2,0(t0)
    blt t1,t2,user_mode*/
    j user_mode

    



