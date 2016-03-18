#!/usr/bin/env bash
# testing that the file is just compiled and is NOT run


path="${BATS_TEST_DIRNAME}/just-compile.c"


@test "--just-compile: causes file to be compiled without running" {
    output=`crun --just-compile "${path}"`
    ! echo "${output}" | grep 'should not run'
    # even after compilation
    output=`crun --just-compile "${path}"`
    ! echo "${output}" | grep 'should not run'
}


@test "--just-compile: returns the path to compiled script" {
    output=`crun --just-compile "${path}"`
    echo "${output}" | grep '/tmp/crun/'
}


@test "--just-compile: passes arguments as compilation flags" {
    crun --just-compile "${path}" -Wall 2>&1 | grep 'implicit declaration'
}
