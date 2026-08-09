.section .data

input_string : .string "atharva"
.globl result_string
result_string: .space 100

.section .text

.globl reverse

reverse:

li t0,0             
la t1,result_string    
la t3,input_string

length_loop:    lb t2,0(t3)
                beq t2,x0,proprev
                addi t0,t0,1
                add t3,a0,t0
                
                j length_loop



proprev:

    addi t3,t3,-1
    
    for_loop: blt t3,a0,end
               lb t6,0(t3)
               sb t6,0(t1)
               addi t1,t1,1
               addi t3,t3,-1 
               j for_loop


   
end:
sb x0,0(t1)
mv a0,t0

ret

