addi x8, x8, 2
addi x9, x9, 3
addi x18, x18, 0
addi x19, x19, 0

for:
bge x19, x9, endfor
add x18, x18, x8
addi x19, x19, 1
blt x19, x9, for

endfor:

