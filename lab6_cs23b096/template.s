.section .text
.global main

main:

li t0,0x2004000     # to stores address of mtimecmp
li t1,10000   
sw t1,0(t0)


la t3,Task_A
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


la t0,context_switch
csrw mtvec,t0

mret	# Enable interrupts

		# configure timer interrupt 
		# set the value of mtimecmp register

context_switch:

		la t5,current# save the context of the interrupted task by looking at the task id (jump to relavent label)
		lw t6,0(t5)

		beq t6,x0,save_context_A
		nop
		j save_context_B


save_context_A:
		la t4,stack_a
		sd t0,0(t4)
		csrr t5,mepc
		sd t5,-8(t4)	# save all the registers and PC value in stack_a
		# mepc stores the value of PC at the time of interrupt

	j switch_to_B

save_context_B:
	la t4,stack_b
	sd t0,0(t4)
	csrr t5,mepc
	sd t5,-8(t4)

	j switch_to_A
		# save all the registers and PC value in stack_b

switch_to_A:
		
	la t4,stack_a
	ld t0,0(t4)
	ld t2,-8(t4)
	csrw mepc,t2

	la t5,current
	li t6,0
	sw t6,0(t5)

j switch# restore the values of registers and PC from stack_a

switch_to_B:

	la t2,first_time
	lw t2,0(t2)
	beqz t2,initial_switch_to_B
	la t5,current
	li t6,1
	sw t6,0(t5)

	la t4,stack_b
	ld t0,0(t4)
	ld t2,-8(t4)
	csrw mepc,t2
# restore the values of registers and PC from stack_b
	

j switch


initial_switch_to_B:

		la t4,Task_B
		csrw mepc,t4


		li t5,1
		la t6,first_time
		sw t5,0(t6)

switch:
		li t2,0x2004000# set the value of mtimecmp and switch to your preferred task
		li t3,0x2000bff8
		lw t4,0(t3)
		li t5,10000
		add t4,t4,t5
		sw t4,0(t2)

	mret
		/*beq current,0, switch_to_B
		beq current,1,switch_to_ A*/

Task_A:
		li t0,0
		
		#li current,0
		loop1:
		li t1,0x0fffffff
			addi t0,t0,1
			blt t0,t1,loop1
			#j finish_a				# increment your reg value

finish_a:
    j finish_a

Task_B:
		li t0,0x03ffffff
		#li t1,0
		#li current,1
		loop2:
		li t1,0
			addi t0,t0,-1
			bgt t0,t1,loop2			# decrement the reg value
finish_b:
    j finish_b

.data
.align



stack_a:  .space  16
stack_b:  .space  16
first_time: .word 0 
current:  .word  0	
