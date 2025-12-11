/*
 * Lab 6:
 * Dijkstra's Algorithm
 */

#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

struct AdjListNode {
  int dest;
  int weight;
  struct AdjListNode *next;
};

struct AdjList {
  struct AdjListNode *head;
};

struct Graph {
  int V;
  struct AdjList *array;
};

struct AdjListNode *newAdjListNode(int dest, int weight) {
  struct AdjListNode *newNode =
      (struct AdjListNode *)malloc(sizeof(struct AdjListNode));
  newNode->dest = dest;
  newNode->weight = weight;
  newNode->next = NULL;
  return newNode;
}

struct Graph *createGraph(int V) {
  struct Graph *graph = (struct Graph *)malloc(sizeof(struct Graph));
  graph->V = V;
  graph->array = (struct AdjList *)malloc(V * sizeof(struct AdjList));
  for (int i = 0; i < V; ++i)
    graph->array[i].head = NULL;
  return graph;
}

void addEdge(struct Graph *graph, int src, int dest, int weight) {
  struct AdjListNode *newNode = newAdjListNode(dest, weight);
  newNode->next = graph->array[src].head;
  graph->array[src].head = newNode;

  newNode = newAdjListNode(src, weight);
  newNode->next = graph->array[dest].head;
  graph->array[dest].head = newNode;
}

struct PQNode {
  int vertex;
  int distance;
};

struct PriorityQueue {
  struct PQNode *nodes;
  int size;
  int capacity;
};

struct PriorityQueue *createPriorityQueue(int capacity) {
  struct PriorityQueue *pq =
      (struct PriorityQueue *)malloc(sizeof(struct PriorityQueue));
  pq->nodes = (struct PQNode *)malloc(capacity * sizeof(struct PQNode));
  pq->size = 0;
  pq->capacity = capacity;
  return pq;
}

void swapNodes(struct PQNode *a, struct PQNode *b) {
  struct PQNode temp = *a;
  *a = *b;
  *b = temp;
}

void heapifyDown(struct PriorityQueue *pq, int idx) {
  int smallest = idx;
  int left = 2 * idx + 1;
  int right = 2 * idx + 2;

  if (left < pq->size &&
      pq->nodes[left].distance < pq->nodes[smallest].distance)
    smallest = left;

  if (right < pq->size &&
      pq->nodes[right].distance < pq->nodes[smallest].distance)
    smallest = right;

  if (smallest != idx) {
    swapNodes(&pq->nodes[idx], &pq->nodes[smallest]);
    heapifyDown(pq, smallest);
  }
}

int isEmpty(struct PriorityQueue *pq) { return pq->size == 0; }

void insert(struct PriorityQueue *pq, int vertex, int distance) {
  if (pq->size == pq->capacity) {
    fprintf(stderr, "Priority queue is full!\n");
    return;
  }

  int i = pq->size;
  pq->nodes[i].vertex = vertex;
  pq->nodes[i].distance = distance;
  pq->size++;

  while (i != 0 && pq->nodes[i].distance < pq->nodes[(i - 1) / 2].distance) {
    swapNodes(&pq->nodes[i], &pq->nodes[(i - 1) / 2]);
    i = (i - 1) / 2;
  }
}

struct PQNode extractMin(struct PriorityQueue *pq) {
  if (isEmpty(pq)) {
    struct PQNode emptyNode = {-1, INT_MAX};
    return emptyNode;
  }

  struct PQNode root = pq->nodes[0];
  pq->nodes[0] = pq->nodes[pq->size - 1];
  pq->size--;
  heapifyDown(pq, 0);

  return root;
}

void printSolution(int dist[], int n, char *rooms[]) {
  printf("Room \t\t Distance from Source\n");
  for (int i = 0; i < n; ++i)
    printf("%-15s \t %d\n", rooms[i], dist[i]);
}

void dijkstra(struct Graph *graph, int src, char *rooms[]) {
  int V = graph->V;
  int dist[V];

  for (int i = 0; i < V; ++i) {
    dist[i] = INT_MAX;
  }

  struct PriorityQueue *pq = createPriorityQueue(V * V);

  dist[src] = 0;
  insert(pq, src, 0);

  while (!isEmpty(pq)) {
    struct PQNode currentNode = extractMin(pq);
    int u = currentNode.vertex;
    int d = currentNode.distance;

    // If we've found a shorter path already, skip this one
    if (d > dist[u]) {
      continue;
    }

    struct AdjListNode *pCrawl = graph->array[u].head;
    while (pCrawl != NULL) {
      int v = pCrawl->dest;
      int weight = pCrawl->weight;

      if (dist[u] != INT_MAX && dist[u] + weight < dist[v]) {
        dist[v] = dist[u] + weight;
        insert(pq, v, dist[v]);
      }
      pCrawl = pCrawl->next;
    }
  }

  printSolution(dist, V, rooms);
  free(pq->nodes);
  free(pq);
}

// --- Main Function ---
int main() {
  int V = 5;
  char *rooms[] = {"Lobby", "Recording Room", "Control Room", "Vocal Booth",
                   "Lounge"};

  struct Graph *graph = createGraph(V);

  addEdge(graph, 0, 1, 5); // Lobby -> Recording Room (5 mins)
  addEdge(graph, 0, 2, 2); // Lobby -> Control Room (2 mins)
  addEdge(graph, 1, 3, 3); // Recording Room -> Vocal Booth (3 mins)
  addEdge(graph, 1, 2, 2); // Recording Room -> Control Room (2 mins)
  addEdge(graph, 2, 4, 4); // Control Room -> Lounge (4 mins)
  addEdge(graph, 3, 2, 1); // Vocal Booth -> Control Room (1 min)
  addEdge(graph, 4, 0, 3); // Lounge -> Lobby (3 mins)

  dijkstra(graph, 0, rooms);

  // Free graph memory
  for (int i = 0; i < V; i++) {
    struct AdjListNode *pCrawl = graph->array[i].head;
    while (pCrawl != NULL) {
      struct AdjListNode *temp = pCrawl;
      pCrawl = pCrawl->next;
      free(temp);
    }
  }
  free(graph->array);
  free(graph);

  return 0;
}

/*
 * Lab 7:
 * Prim's and Kruskal's MST
 */

#include <stdio.h>
#include <stdlib.h>

#define INF 999999

// Kruskal's Algorithm Structures
struct Edge {
  int src, dest, weight;
};

struct Graph {
  int V, E;
  struct Edge *edge;
};

struct subset {
  int parent;
  int rank;
};

struct Graph *createGraph(int V, int E) {
  struct Graph *graph = (struct Graph *)malloc(sizeof(struct Graph));
  graph->V = V;
  graph->E = E;
  graph->edge = (struct Edge *)malloc(graph->E * sizeof(struct Edge));
  return graph;
}

int find(struct subset subsets[], int i) {
  if (subsets[i].parent != i)
    subsets[i].parent = find(subsets, subsets[i].parent);
  return subsets[i].parent;
}

void Union(struct subset subsets[], int x, int y) {
  int xroot = find(subsets, x);
  int yroot = find(subsets, y);

  if (subsets[xroot].rank < subsets[yroot].rank)
    subsets[xroot].parent = yroot;
  else if (subsets[xroot].rank > subsets[yroot].rank)
    subsets[yroot].parent = xroot;
  else {
    subsets[yroot].parent = xroot;
    subsets[xroot].rank++;
  }
}

int myComp(const void *a, const void *b) {
  struct Edge *a_edge = (struct Edge *)a;
  struct Edge *b_edge = (struct Edge *)b;
  return a_edge->weight > b_edge->weight;
}

void KruskalMST(struct Graph *graph, char *vertices[]) {
  int V = graph->V;
  struct Edge result[V];
  int e = 0;
  int i = 0;

  qsort(graph->edge, graph->E, sizeof(graph->edge[0]), myComp);

  struct subset *subsets = (struct subset *)malloc(V * sizeof(struct subset));

  for (int v = 0; v < V; ++v) {
    subsets[v].parent = v;
    subsets[v].rank = 0;
  }

  while (e < V - 1 && i < graph->E) {
    struct Edge next_edge = graph->edge[i++];

    int x = find(subsets, next_edge.src);
    int y = find(subsets, next_edge.dest);

    if (x != y) {
      result[e++] = next_edge;
      Union(subsets, x, y);
    }
  }

  printf("\nMinimum Spanning Tree (Kruskal's Algorithm):\n");
  int minimumCost = 0;
  for (i = 0; i < e; ++i) {
    printf("%s -- %s == %d\n", vertices[result[i].src],
           vertices[result[i].dest], result[i].weight);
    minimumCost += result[i].weight;
  }
  printf("Minimum Cost: %d\n", minimumCost);
  free(subsets);
}

// Prim's Algorithm
int minKey(int key[], int mstSet[], int V) {
  int min = INF, min_index = -1;

  for (int v = 0; v < V; v++)
    if (mstSet[v] == 0 && key[v] < min)
      min = key[v], min_index = v;

  return min_index;
}

void printPrimMST(int parent[], int **graph, int V, char *vertices[]) {
  printf("\nMinimum Spanning Tree (Prim's Algorithm):\n");
  int minimumCost = 0;
  for (int i = 1; i < V; i++) {
    printf("%s -- %s == %d\n", vertices[parent[i]], vertices[i],
           graph[i][parent[i]]);
    minimumCost += graph[i][parent[i]];
  }
  printf("Minimum Cost: %d\n", minimumCost);
}

void PrimMST(int **graph, int V, char *vertices[]) {
  int parent[V];
  int key[V];
  int mstSet[V];

  for (int i = 0; i < V; i++) {
    key[i] = INF;
    mstSet[i] = 0;
  }

  key[0] = 0;
  parent[0] = -1;

  for (int count = 0; count < V - 1; count++) {
    int u = minKey(key, mstSet, V);
    if (u == -1)
      continue;
    mstSet[u] = 1;

    for (int v = 0; v < V; v++)
      if (graph[u][v] && mstSet[v] == 0 && graph[u][v] < key[v]) {
        parent[v] = u;
        key[v] = graph[u][v];
      }
  }

  printPrimMST(parent, graph, V, vertices);
}

int main() {
  int V = 5;
  char *vertices[5] = {"Audio Interface", "DAW", "Microphone", "Synthesizer",
                       "Monitor Speakers"};

  // Adjacency Matrix for Prim's
  int **adjMatrix = (int **)malloc(V * sizeof(int *));
  for (int i = 0; i < V; i++) {
    adjMatrix[i] = (int *)malloc(V * sizeof(int));
  }

  int matrix[5][5] = {{0, 10, 20, 0, 15},
                      {10, 0, 25, 30, 0},
                      {20, 25, 0, 0, 35},
                      {0, 30, 0, 0, 5},
                      {15, 0, 35, 5, 0}};

  for (int i = 0; i < V; i++) {
    for (int j = 0; j < V; j++) {
      adjMatrix[i][j] = matrix[i][j];
    }
  }

  // Edge list for Kruskal's
  int E = 7;
  struct Graph *graph = createGraph(V, E);

  graph->edge[0].src = 0;
  graph->edge[0].dest = 1;
  graph->edge[0].weight = 10;

  graph->edge[1].src = 0;
  graph->edge[1].dest = 2;
  graph->edge[1].weight = 20;

  graph->edge[2].src = 0;
  graph->edge[2].dest = 4;
  graph->edge[2].weight = 15;

  graph->edge[3].src = 1;
  graph->edge[3].dest = 2;
  graph->edge[3].weight = 25;

  graph->edge[4].src = 1;
  graph->edge[4].dest = 3;
  graph->edge[4].weight = 30;

  graph->edge[5].src = 2;
  graph->edge[5].dest = 4;
  graph->edge[5].weight = 35;

  graph->edge[6].src = 3;
  graph->edge[6].dest = 4;
  graph->edge[6].weight = 5;

  int choice;
  printf("Music Studio Equipment Network MST\n");
  printf("Vertices: Audio Interface, DAW, Microphone, Synthesizer, Monitor "
         "Speakers\n\n");
  printf("Choose an algorithm:\n");
  printf("1. Kruskal's Algorithm\n");
  printf("2. Prim's Algorithm\n");
  printf("Enter your choice: ");
  scanf_s("%d", &choice);

  switch (choice) {
  case 1:
    KruskalMST(graph, vertices);
    break;
  case 2:
    PrimMST(adjMatrix, V, vertices);
    break;
  default:
    printf("Invalid choice.\n");
  }

  for (int i = 0; i < V; i++) {
    free(adjMatrix[i]);
  }
  free(adjMatrix);
  free(graph->edge);
  free(graph);
  return 0;
}

/*
 * Lab 7:
 * Floyd-Warshall's All Pair Shortest path
 * DP Program
 */

#include <stdio.h>
#include <stdlib.h>

#define INF 9999
#define MAX_V 100

void printSolution(int dist[MAX_V][MAX_V], int V) {
  for (int i = 0; i < V; i++) {
    for (int j = 0; j < V; j++) {
      if (dist[i][j] == INF) {
        printf("%7s", "INF");
      } else {
        printf("%7d", dist[i][j]);
      }
    }
    printf("\n");
  }
}

void floydWarshall(int graph[MAX_V][MAX_V], int V) {
  int dist[MAX_V][MAX_V];
  int i, j, k;

  // Initialize the solution matrix same as input graph matrix
  for (i = 0; i < V; i++) {
    for (j = 0; j < V; j++) {
      dist[i][j] = graph[i][j];
    }
  }

  // Add all vertices one by one to the set of intermediate vertices.
  for (k = 0; k < V; k++) {
    for (i = 0; i < V; i++) {
      for (j = 0; j < V; j++) {
        if (dist[i][k] != INF && dist[k][j] != INF &&
            dist[i][k] + dist[k][j] < dist[i][j]) {
          dist[i][j] = dist[i][k] + dist[k][j];
        }
      }
    }
  }

  printSolution(dist, V);
}

int main() {
  int V = 4;
  int graph[MAX_V][MAX_V];

  printf("Using dummy graph with %d vertices.\n", V);

  // Initialize graph
  for (int i = 0; i < V; i++) {
    for (int j = 0; j < V; j++) {
      if (i == j) {
        graph[i][j] = 0; // Distance to itself is 0
      } else {
        graph[i][j] = INF; // Initialize with infinity
      }
    }
  }

  // Define dummy edges
  // 0 -> 1 (5)
  // 0 -> 3 (10)
  // 1 -> 2 (3)
  // 2 -> 3 (1)
  graph[0][1] = 5;
  graph[0][3] = 10;
  graph[1][2] = 3;
  graph[2][3] = 1;

  printf("Graph initialized with dummy data.\n");

  // Run the Floyd Warshall algorithm
  floydWarshall(graph, V);

  return 0;
}

/*
 * Lab 8:
 * Largest Common Substring
 */

#include <stdio.h>
#include <string.h>

void printTable(int dp[100][100], int m, int n, char *X, char *Y) {
  printf("\nLCS Table:\n      ");
  for (int j = 0; j < n; j++) {
    printf("%c  ", Y[j]);
  }
  printf("\n");

  for (int i = 0; i <= m; i++) {
    if (i == 0)
      printf("   ");
    else
      printf("%c  ", X[i - 1]);

    for (int j = 0; j <= n; j++) {
      printf("%d  ", dp[i][j]);
    }
    printf("\n");
  }
}

int main() {
  char X[100];
  char Y[100];

  printf("Enter first string: ");
  scanf_s("%s", X);
  printf("Enter second string: ");
  scanf_s("%s", Y);

  if (strlen(X) == 0 || strlen(Y) == 0) {
    printf("Invalid or empty strings provided.\n");
    return 1;
  }

  int m = strlen(X);
  int n = strlen(Y);

  int dp[100][100];

  // main thingy
  for (int i = 0; i <= m; i++) {
    for (int j = 0; j <= n; j++) {

      if (i == 0 || j == 0) {
        dp[i][j] = 0;
      } else if (X[i - 1] == Y[j - 1]) {
        dp[i][j] = dp[i - 1][j - 1] + 1;
      } else {
        dp[i][j] = (dp[i - 1][j] > dp[i][j - 1]) ? dp[i - 1][j] : dp[i][j - 1];
      }
    }
  }

  printTable(dp, m, n, X, Y);

  int length = dp[m][n];
  printf("\nLCS Length: %d\n", length);

  char lcs[100];
  lcs[length] = '\0';

  int i = m, j = n;
  while (i > 0 && j > 0) {
    if (X[i - 1] == Y[j - 1]) {
      lcs[length - 1] = X[i - 1];
      i--;
      j--;
      length--;
    } else if (dp[i - 1][j] > dp[i][j - 1]) {
      i--;
    } else {
      j--;
    }
  }

  printf("LCS: %s\n", lcs);

  return 0;
}

/*
 * Lab 9:
 * Travelling Salesman
 * Dynamic Programming
 */

#include <stdio.h>

#define N 4
#define INF 9999

int dist[N][N] = {
    {0, 10, 15, 20}, {10, 0, 35, 25}, {15, 35, 0, 30}, {20, 25, 30, 0}};

// Memoization table
int dp[1 << N][N];

int next_city[1 << N][N];

int tsp(int mask, int pos) {
  if (mask == ((1 << N) - 1)) {
    return dist[pos][0];
  }

  if (dp[mask][pos] != -1) {
    return dp[mask][pos];
  }

  int minCost = INF;
  int bestNext = -1;

  for (int city = 0; city < N; city++) {
    if ((mask & (1 << city)) == 0) { // If city is not in mask
      int currentCost = dist[pos][city] + tsp(mask | (1 << city), city);

      if (currentCost < minCost) {
        minCost = currentCost;
        bestNext = city;
      }
    }
  }

  next_city[mask][pos] = bestNext;

  return dp[mask][pos] = minCost;
}

void printTour() {
  int mask = 1;
  int pos = 0;
  printf("Tour: 0");

  while (mask != ((1 << N) - 1)) {
    int next = next_city[mask][pos];
    printf(" -> %d", next);

    mask |= (1 << next);
    pos = next;
  }

  printf(" -> 0\n");
}

int main() {
  for (int i = 0; i < (1 << N); i++) {
    for (int j = 0; j < N; j++) {
      dp[i][j] = -1;
    }
  }

  printf("Traveling Salesperson Problem using Dynamic Programming\n");
  printf("Number of cities: %d\n\n", N);

  printf("Cost Matrix:\n");
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      printf("%4d", dist[i][j]);
    }
    printf("\n");
  }
  printf("\n");

  int minCost = tsp(1, 0);

  printf("Minimum Cost: %d\n", minCost);
  printTour();

  return 0;
}
