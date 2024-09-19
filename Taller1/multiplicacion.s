# multiplicacion con assembly
addi x8, x0, 2   
addi x9, x0, 3   
addi x18, x0, 0  #cargo en x18 el valor inicial

addi x10, x8, 0  
addi x11, x9, 0  

jal ra, multiplicacion

multiplicacion:
addi sp, sp, -8   
sw x19, 0(sp)     
addi x19, x0, 0  

for:
bge x19, x9, endfor 
add x18, x18, x8   
addi x19, x19, 1    
blt x19, x9, for     

endfor:
lw x19, 0(sp)        
addi sp, sp, 8       
