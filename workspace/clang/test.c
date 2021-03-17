#include <stdio.h>

int strlen(char *);

void main() {
    char *string = "hello world";
    int string_length = strlen(string);
    printf("string_length: %i\n", string_length);
}
