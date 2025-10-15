#include<stdio.h>

int main() {
  int a = 10;

  int* b = &a;
  int* c = &a;

  *b = 112;
  *c = 123;

  printf("%d %d",b,c);
}
