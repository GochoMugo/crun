#!/usr/bin/env crun
/* -Wall -O3 */
#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Hello, world! %s\n", argv[1]);

    /* Ensure we can pass arguments */
    if (argc != 2) {
        return 1;
    }

    return 0;
}
