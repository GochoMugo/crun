#!/usr/bin/env crun
/* -Wall -O3 */
#include <stdio.h>

int main(int argc, char *argv[]) {
    puts("Hello, world! Koninchwa!");

    /* Ensure we can pass arguments */
    if (argc != 2) {
        return 1;
    }

    return 0;
}
