#include <stdio.h>
// #include <stdlib.h>
#include <string.h>

int main() {
    char* name = "emre can ocak";
    char buffer[255];
    strcpy(buffer, name);
    printf("%s\n", name);
    printf("%s\n", buffer);
    tolower('e');
}
