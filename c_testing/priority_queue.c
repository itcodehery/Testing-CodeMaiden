#include <stdio.h>

typedef struct {
  int data;
  int priority;
} Element;

typedef struct {
  Element items[100];
  int size;
} PQueue;

void init(PQueue *pq) { pq->size = 0; }

void enqueue(PQueue *pq, int data, int priority) {
  if (pq->size < 100) {
    pq->items[pq->size].data = data;
    pq->items[pq->size].priority = priority;
    pq->size++;
  }
}

int dequeue(PQueue *pq) {
  if (pq->size == 0)
    return -1;

  int max_index = 0;

  for (int i = 1; i < pq->size; i++) {
    if (pq->items[i].priority < pq->items[max_index].priority) {
      max_index = i;
    }
  }

  int result = pq->items[max_index].data;

  for (int i = max_index; i < pq->size - 1; i++) {
    pq->items[i] = pq->items[i + 1];
  }
  pq->size--;

  return result;
}

int main() {
  PQueue pq;
  init(&pq);

  enqueue(&pq, 10, 3);
  enqueue(&pq, 20, 1);
  enqueue(&pq, 30, 2);

  printf("%d\n", dequeue(&pq));
  printf("%d\n", dequeue(&pq));
  printf("%d\n", dequeue(&pq));

  return 0;
}
