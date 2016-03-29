#!/usr/bin/env bash
# testing that the bash string is (not) evaluated


path_01="${BATS_TEST_DIRNAME}/eval-hacks/01-run-executable.c"
path="${path_01}"


setup() {
    unset CRUN_DO_EVAL
}


teardown() {
    export CRUN_DO_EVAL=1
}


@test "by default: '\$()' and '\`\`' are not evaluated [eval-hack 01]" {
    local file="${BATS_TMPDIR}/crun-safe.txt"
    rm -f "${file}"
    file="${file}" crun "${path_01}" || true
    ! test -e "${file}"
}


@test "--do-eval: causes bash string to be evaluated" {
    local file="${BATS_TMPDIR}/crun-eval.txt"
    rm -f "${file}"
    file="${file}" crun --do-eval "${path}" || true
    test -e "${file}"
}


@test "\${CRUN_DO_EVAL}: enables bash string evaluation" {
    local file="${BATS_TMPDIR}/crun-eval-env.txt"
    rm -f "${file}"
    file="${file}" CRUN_DO_EVAL=1 crun "${path}" || true
    test -e "${file}"
}
