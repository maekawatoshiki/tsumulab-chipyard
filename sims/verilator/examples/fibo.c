#include <stdio.h>

int fibo(int x) {
  if (x <= 2) return 1;
  return fibo(x - 1) + fibo(x - 2);
}

int main() {
  printf("fibo(10) = %d\n", fibo(10));
  return 0;
}
