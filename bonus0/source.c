#include <stdio.h>
#include <string.h>
#include <unistd.h>

char *p(char *dest, char *s)
{
  char buf[4096];

  puts(s);
  read(0, buf, 4096);
  *(strchr(buf, '\n')) = 0;
  return strncpy(dest, buf, 20);
}

char *pp(char *main_buffer)
{
  char input1[20];
  char input2[20];

  p(input1, " - ");
  p(input2, " - ");
  strcpy(main_buffer, input1);
  main_buffer[strlen(main_buffer)] = ' ';
  return strcat(main_buffer, input2);
}

int main(void)
{
  char str[42];
  
  pp(str);
  puts(str);
  return 0;
}