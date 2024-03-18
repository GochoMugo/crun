#!/usr/bin/env bash
# testing that the bash string is (not) evaluated


path="${BATS_TEST_DIRNAME}/eval-hacks/01-run-executable.c"
CRUN_DO_EVAL_PREV=


setup() {
    CRUN_DO_EVAL_PREV=${CRUN_DO_EVAL}
    unset CRUN_DO_EVAL
}


teardown() {
    export CRUN_DO_EVAL=${CRUN_DO_EVAL_PREV}
}


@test "by default: '\$()' and '\`\`' are not evaluated [eval-hack 01]" {
    local file="${BATS_TMPDIR}/crun-safe.txt"
    rm -f "${file}"
    file="${file}" crun "${path}" || true
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
