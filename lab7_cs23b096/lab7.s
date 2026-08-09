.section .text
.global main


main:

    la t1,supervisor
    csrw mepc,t1  #ensures that the address of supervisor mode is given to machine
    csrr t1,mstatus 
    li t2,0x1800  #11th and 12th bit 
    or t1,t1,t2
    csrw mstatus,t1
    
    mret
    # Jump to supervisor mode


supervisor:
################ Initialize your page tables here ################
   
   

    li t0, 0x81000000

    li t1,0x82001       #first entry
    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)

    li t1,0x82000     #second entry
    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,16(t0)        #third entry 



    li t0,0x82001000        #first level page table

    li t1,0x83001
    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)

    li t0,0x82000000       #first level page table 
    li t1,0x83000
    slli t1,t1,10
    ori t1,t1,0x1
    sd t1,0(t0)
    

    li t0,0x83000000        #setting the leaf nodes,physical mapping
    li t1,0x80000
    slli t1,t1,10
    ori t1,t1,0x6F
    sd t1,0(t0)

    li t0,0x83001000        #setting the leaf nodes
    li t1,0x80001
    slli t1,t1,10
    ori t1,t1,0x7F
    sd t1,0(t0)

    li t0,0x83001000       #setting the leaf nodes
    li t1,0x80002
    slli t1,t1,10
    ori t1,t1,0x6F
    sd t1,8(t0)






    



####################################################################


li t1,0x0
csrw sstatus,t1



    # Prepare jump to user mode






################ DO NOT MODIFY THESE INSTRUCTIONS ################
    la t1,satp_config  # load satp val
  
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0
    csrrw zero, sepc, t4 
    sret
####################################################################


.align 12
user_code:
nop
    la t1,var1
    la t2,var2
    la t3,var3
    la t4,var4
    j user_code


.data
.align 12
var1:  .word  1
var2:  .word  2
var3:  .word  3
var4:  .word  4

.align 12
satp_config: .dword  0x8000000000081000 # Value to set in sat, 16 bit number