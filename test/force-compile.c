#!/usr/bin/env crun
/* -DCRUN_ENV_VAR=${CRUN_ENV_VAR} -Wall -O3 */

#ifndef CRUN_ENV_VAR
#define CRUN_ENV_VAR "unknown"
#endif

#include <stdio.h>

int main(void) {
    printf("%s\n", CRUN_ENV_VAR);
    return 0;
}
