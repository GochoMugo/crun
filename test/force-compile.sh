#!/usr/bin/env bash
# testing that we can forcefully cause compilation
# we are using an environment variable as macro, that is set during
# compilation, to detect changes


path="${BATS_TEST_DIRNAME}/force-compile.c"


@test "--force-compile: causes file to be compiled regardless..." {
    export CRUN_ENV_VAR='"first"'
    output=$(crun "${path}")
    echo "${output}" | grep 'first'
    export CRUN_ENV_VAR='"second"'
    output=$(crun --force-compile "${path}")
    echo "${output}" | grep 'second'
}
