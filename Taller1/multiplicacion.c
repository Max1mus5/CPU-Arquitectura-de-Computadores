/* cabecera de proyecto en C
 */
#include <stdio.h>

int main(){
  printf("Multiplicacion\n");
  int numero1=2;// addi x8, x8, 2
  int numero2=3;//aadi x9, x9, 3
  int suma = 0;//addi x18, x0, 0
  for(int i = 0; i < numero2; i++){//addi x19, x19, 0
    suma+=numero1;
  }//blt x19, x9, for
  printf("El resultado de la multiplicacion es: %d\n", suma);

  return 0;

    
}