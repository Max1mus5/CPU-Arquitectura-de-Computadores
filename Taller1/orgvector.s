# implementacion en assembly de orgvector:
# algoritmo de ordenamiento de las primeras n posiciones de un vector de enteros de 32bits

orgvector: 
#creo pila y separo espacio
addi sp, sp, -24
sw x8, 0(sp)
sw x9, 4(sp)
sw x18, 8(sp)
sw x19, 12(sp)
sw x20, 16(sp)
sw x21, 20(sp)

#recibir argumentos
addi x8, x10, 0
addi, x9, x11, 0

#inicializo variables
addi x18, x0, 0
addi x19, x0, 0
addi x20, x0, 0
lw x5, 0(x10)        # cargo el primer valor del vector a x5
li x6, 4             # como el valor inmediato son 4bytes entonces cargo en x6 el valor 4

# calcular vectorSize = (sizeof(vector[0]) * n) / sizeof(int)
mul x5, x5, x11     # Multiply sizeof(vector[0]) by n
div x5, x5, x6     # Diviido el valor por sizeof(int) = 4
addi x21, x5, 0     # cargo en x21 el valor resultante








