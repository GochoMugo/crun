#!/usr/bin/env crun
/* ../deps/*/*.c -I"../deps" */
#include <stdio.h>
#include <stdlib.h>
#include <str-replace/str-replace.h>

int main(void) {
    char *pwd = getenv("PWD");
    char *cache_dir = getenv("CRUN_CACHE_DIR");

    // ensure we got the env. value
    if (cache_dir == NULL) {
        puts("${CRUN_CACHE_DIR} not set");
        return 1;
    }

    // check to see if this script's executable is compiled to
    // ${CRUN_CACHE_DIR}/${PWD}/test/cache.c
    // the executable will be invoked by make(1) in .. (1 dir up)
    char *dest_path;
    asprintf(&dest_path, "%s/test/cache.c", pwd);
    dest_path = str_replace(dest_path, "/", ".");
    asprintf(&dest_path, "%s/%s", cache_dir, dest_path);

    // just try opening the file
    FILE *file;
    if ((file = fopen(dest_path, "r")) == NULL) {
        printf("executable not found at %s", dest_path);
        return 1;
    }
    fclose(file);
    return 0;
}
