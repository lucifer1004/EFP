#include <stdio.h>

int main() {
  char *name;

  printf("What is your name? ");
  scanf("%s", name);
  printf("Hello, %s, nice to meet you!", name);

  return 0;
}