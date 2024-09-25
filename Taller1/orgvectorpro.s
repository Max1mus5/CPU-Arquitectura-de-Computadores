.data
vector:   .word 2, 1, 4, 3, 5   
    .text
    .globl main
    .globl orgvector

# Salto inmediato al inicio del programa
beq x0, x0, main

main:
    la x10, vector                 
    li x11, 5                      
    jal x1, orgvector              
    jal x0, fin                  

orgvector:
addi sp, sp, -12
sw x18, 0(sp) 
sw x19, 4(sp) 
sw x20, 8(sp) 

# x11 contiene el valor de n
addi x18, x0, 0
blt x18, x11, while1

while1:
beq x11, x0, finFuncion
addi x19, x18, 1
blt x19, x11, while2
addi x18, x18, 1
addi x19, x19, -1
beq x0, x0, while1

while2:
beq x19, x11, while1
lw x5, x18(x10)
lw x6, x19(x10)
addi x19, x19, 1
blt x5, x6, while2
bgt x5, x6, swap

swap:
addi x20, x5, 0
sw x5, x19(x10)
sw x20, x18(x10)
beq x0, x0, while2

finFuncion:
lw x19, 0(sp)
lw x18, 4(sp)
lw x11, 8(sp)
lw x8, 12(sp)
lw x20, 16(sp)
addi sp, sp, 20
jalr x0, x0, 0

fin:
li a0, 0                       # Cargar valor de retorno 0
ecall                          # Llamar a la syscall de salida





