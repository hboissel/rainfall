#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char *auth, *service;

int main() {
  char input[160];
  char *ret, *str;

  while (1) {
    printf("%p, %p \n", auth, service);

    ret = fgets(input, 128, stdin);
    if (!ret)
      break;
    if (!strncmp(input, "auth ", 5)) {
      auth = (char*)malloc(4);
      auth[0] = 0;
      if (strlen(input + 5) <= 30)
        strcpy(auth, input + 5);
    }
    else if (!strncmp(input, "reset", 5)) {
      free(auth);
    }
    else if (!strncmp(input, "service", 6)) {
      service = strdup(input + 7);
    }
    else if (!strncmp(input, "login", 5)) {
      if (*(auth + 32))
        system("/bin/sh");
      fwrite("password:\n", 1, 10, stdout);
    }
  }
}
