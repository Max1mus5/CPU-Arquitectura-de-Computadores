#include <stdio.h>

/* prototipo de orgvector: 
algoritmo de ordenamiento de las primeras n posiciones de un vector de enteros de 32bits */

void orgvector(int vector[], int n);

int main() {
  // definir vector
  int vector[5] = {2, 1, 4, 3, 5};
  int n = sizeof(vector) / sizeof(vector[0]);

  // llamado a la funcion orgvector
  orgvector(vector, n);  
  printf("El vector ordenado es: ");
  for (int i = 0; i < n; i++) {
    printf("%d ", vector[i]);
  }
  printf("\n");
  return 0;
}

void orgvector(int vector[], int n) {
  int numeroActual, numeroSiguiente, intercambioActual;
  // validar que n sea menor o igual al tamaño del vector
  int vectorSize = sizeof(vector[0]) * n / sizeof(int); 
  if (n > vectorSize) {
    printf("El tamaño del vector es mayor que el n:  %i", n, "\n");
    return;
  }
  for (int numeroActual = 0; numeroActual < n - 1; numeroActual++) {
    for (int numeroSiguiente = 0; numeroSiguiente < n - numeroActual - 1; numeroSiguiente++) {
      if (vector[numeroSiguiente] > vector[numeroSiguiente + 1]) {
        int intercambioActual = vector[numeroSiguiente];
        vector[numeroSiguiente] = vector[numeroSiguiente + 1];
        vector[numeroSiguiente + 1] = intercambioActual;
      }
    }
  }
  // metodo: ordenamiento por intercambio (bubble sort)
  // complejidad algoritmica: O(n^2), complejidad en memoria: O(1)
}