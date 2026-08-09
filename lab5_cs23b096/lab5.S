.section .text
.global machine_mode

machine_mode:


la t0,supervisor_mode
csrw mepc,t0

li t0,0x1800

csrr t1,mstatus 

not t2,t0

and t1,t1,t2

li t3,(1<<11)       #supervisor mode
or t1,t1,t3

csrw mstatus,t1
la t6,machine_trap
csrw mtvec,t6

li t5,1
slli t5,t5,8       #yet to be confirmed
csrs medeleg,t5


mret

supervisor_mode:
la t4,supervisor_trap
csrw stvec,t4
la t0,user_mode
csrw sepc,t0



li t0,0x1800

csrr t1,sstatus 

not t2,t0

and t1,t1,t2

csrw sstatus,t1

#la stvec,supervisor_trap
sret


user_mode:

li a0,1
li a1,3
li a2,7

ecall 

supervisor_trap:

#csrr t0,scause
#csrr t1,sepc

ecall

la t0,user_mode
csrw sepc,t0
sret

machine_trap:

csrr t0,mepc
addi t0,t0,4
csrw mepc,t0
mret
#csrr t0,mcause
#csrr t1,mepc

#ecall