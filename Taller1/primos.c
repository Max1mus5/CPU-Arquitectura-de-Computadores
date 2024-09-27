#include <stdio.h>
#include <stdbool.h>

int modint (int x, int y) {
    while (x >= y)
        x -= y;
    return x;
}

int valprimo (int x, int *q) {
    bool flag = true;
    while (*q != 1) {
        if (modint(x, *q) == 0) {
            flag = false;
            break;
        }
        q -= 1;
    }
    return flag;      
}

int *primos (int n, int* p) {
    int i = 2, *q;
    if (n == 0)
        return p;
    *p = 0;
    if (n == 1)
        return p;
    *(p + 1) = 1;
    if (n == 2)
        return p;
    q = p + 1;
    n -= 2;
    while (n) {
        if (valprimo (i, q)){
            q += 1;
            *q = i;
            n--;
        }
        i++;
    }
    return p;
}
int main() {
  printf("Primos:\n");
  int n = 10;
  int pr[10]={0};
  int *p = primos(n, pr);
  while (n--) {
    printf("%d\n", *p);
    p += 1;
  } 
  return 0;
}