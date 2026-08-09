.section .data

str : .asciz "Move from rod X to rod Y\n" #define the string in data section
of your code.
x : .word 14 # idx of x in str
y : .word 23 # idx of y in str


main:

li a0, 1 #pass the file descriptor: 1 is stdout
la a1, str #pass the address of the string
li a2, 25 #pass the length of the string
li a7, 64 #pass the syscall number for write
ecall #make syscall

tower_hanoi:



base_case:


