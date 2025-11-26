#include <stdio.h>
#define INF 999
#define MAX 10

int main() {
  int adj[MAX][MAX], n;
  printf("\nEnter the number of nodes (<10): ");
  scanf_s("%d", &n);

  if (n > 10 || n < 2) {
    printf("\nInvalid n value!");
  }
}
