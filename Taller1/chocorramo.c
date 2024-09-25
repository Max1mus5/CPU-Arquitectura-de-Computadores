#include <stdio.h>

int unos(int x) {
  int acc = 0;
  int r = 0;
  for (int i = 0; i < 32; i++) {
    r = x & 1;
    acc += r;
    x >>= 1;
  }
  return acc;
}
 
int main() {
  int numero = 5;
  int numeroDeUnos =unos(numero);
  printf("El numero de unos en %d es: %d\n", numero, numeroDeUnos);
  return 0;
}