#include <stdio.h>

int cuadrado(int x) {
    int result = 0, i = x;
    while (i) {
        result += x;
        i -= 1;
    }
    return result;
}

int main() {
    int numero = 7;  // Puedes cambiar el valor para probar con diferentes números
    int resultado = cuadrado(numero);
    printf("El cuadrado de %d es %d\n", numero, resultado);
    return 0;
}