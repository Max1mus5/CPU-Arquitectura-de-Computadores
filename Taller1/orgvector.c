#include <stdio.h>

/* prototipo de orgvector: 
algoritmo de ordenamiento de las primeras n posiciones de un vector de enteros de 32bits */

void orgvector(int vector[], int n);

int main() {
  // definir vector
  int vector[5] = {2, 1, 4, 3, 5};
  int n =5  ;
  int size = sizeof(vector) / sizeof(vector[0]);

  // llamado a la funcion orgvector
  orgvector(vector, n);  
  printf("El vector ordenado es: ");
  for (int i = 0; i < size; i++) {
    printf("%d ", vector[i]);
  }
  printf("\n");
  return 0;
}

void orgvector(int vector[], int n) {
  int numeroActual = 0;
  int numeroSiguiente = numeroActual + 1;
  while(n > 0){
    while(numeroSiguiente < n){
      if(vector[numeroActual] > vector[numeroSiguiente]){
        int intercambioActual = vector[numeroActual];
        vector[numeroActual] = vector[numeroSiguiente];
        vector[numeroSiguiente] = intercambioActual;
      }
      numeroSiguiente++;
    }
    numeroActual++;
    n--;
  }
  // metodo: ordenamiento por intercambio (bubble sort)
  // complejidad algoritmica: O(n^2), complejidad en memoria: O(1)
}