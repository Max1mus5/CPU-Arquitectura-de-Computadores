# implementacion en assembly de orgvector:
# algoritmo de ordenamiento de las primeras n posiciones de un vector de enteros de 32bits

orgvector: 
  #creo pila y separo espacio
  addi sp, sp, -24
  sw x8, 0(sp) # vector
  sw x9, 4(sp) #intercambioActual
  sw x18, 8(sp) # numeroSiguiente
  sw x19, 12(sp) # numeroActual
  sw x20, 16(sp) # n
  sw x21, 20(sp) # vectorSize

  #recibir argumentos
  addi x8, x10, 0 # vector
  addi, x20, x11, 0 # n

  #inicializo variables
  addi x18, x19, 1 # numeroSiguiente = numeroActual + 1
  addi x19, x0, 0
  addi x20, x0, 0
  lw x5, 0(x10)        # cargo el primer valor del vector a x5
  li x6, 4             # como el valor inmediato son 4bytes entonces cargo en x6 el valor 4

  # calcular vectorSize = (sizeof(vector[0]) * n) / sizeof(int)
  mul x5, x5, x11     # Multiply sizeof(vector[0]) by n
  div x5, x5, x6     # Diviido el valor por sizeof(int) = 4
  addi x21, x5, 0     # cargo en x21 el valor resultante

  # condicional para validar que n sea menor o igual al tamaño del vector
  bgt  x21, x20, error

error:

# logica de ordenamiento por intercambio (bubble sort)

forNumeroActual:
  addi x5, x20, -1 # n-1
  beq x18, x5, finAlgoritmo # cuando numeroActual sea igual que n-1 finaliza
  blt x19, x20, forNumeroSiguiente
  addi x19, x19, 1

forNumeroSiguiente:
  beq x18, x20, forNumeroActual
  lw x6, x19(x8)  # cargar el valor en la posicion de numeroActual del vector en x5
  lw x7, x18(x8)  # cargar el valor en la posicion de numeroSiguiente del vector en x6
  addi x18, x18, 1 # numeroSiguiente++
  blt x6, x7, forNumeroSiguiente # si numeroActual es menor que numeroSiguiente entonces continua comparando
  beq x6, x7, forNumeroSiguiente # si numeroActual es igual que numeroSiguiente entonces continua comparando
  bgt x6, x7, swap # si numeroActual es mayor que numeroSiguiente entonces intercambia

swap:
  addi x9, x7, 0 # intercambioActual = numeroActual
  sw x7, x6(x8) # vector[numeroActual] = vector[numeroSiguiente]
  sw x9, x7(x8) # vector[numeroSiguiente] = intercambioActual
  beq x0, x0, forNumeroSiguiente

finAlgoritmo:
  # return 0 para indicar que el algoritmo termino correctamente
  jalr x0, x0, 0


#funcion main para ejecutar el algoritmo
beq x0, x0, main

.data
vector:
    .word 23, 9, 14, 56, 3  # Define 5 enteros desordenados

.text
main:
    la x10, vector  # Cargar la dirección base del vector en x10
    li x11, 5       # Cargar el valor 5 (tamaño del vector) en x11

    # Llamada a la función orgvector (tu algoritmo de ordenamiento)
    jal x1, orgvector  # Saltar a la rutina de ordenamiento












