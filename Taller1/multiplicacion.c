/* cabecera de proyecto en C
 */
#include <stdio.h>

int mult(int x, int y);//definicion de funcion

int main(){
  printf("Multiplicacion\n");
  int numero1=2;
  int numero2=3;
  int suma = mult(numero1, numero2);
  printf("El resultado de la multiplicacion es: %d\n", suma); 
  return 0;

    
}

int mult(int x, int y){
  int suma = 0;
  for(int i = 0; i < y; i++){
    suma+=x;
  }
  return suma;
}
  