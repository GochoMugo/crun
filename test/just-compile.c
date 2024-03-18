#!/usr/bin/env crun

#ifdef TEST
#warning 'test var set'
#endif

#include <stdio.h>

int main(void) {
    puts("should not run");
    return 0;
}
