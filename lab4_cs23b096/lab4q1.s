.section .data
fn: .asciz "Atharva"
ln: .asciz "Moghe"
new_course : .asciz "CS2610"
.globl course_name

.section .text

.globl getcourse
.globl display_profile

.globl main

main:

la a0,fn
la a1,ln
la a2,course_name      
la t0,new_course        
sd t0,0(a2)
ld a2,course_name
j display_profile

li a7,93

ecall

