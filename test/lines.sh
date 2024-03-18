#!/usr/bin/env bash
# testing that lines are kept intact

path="${BATS_TMPDIR}/lines.c"

function setup() {
    rm -f "${path}"
}

# since this test relies on the crun to fail, temp files
# are not cleaned
@test "line numbers are preserved" {
    crun --create "${path}"
    echo CATCHME >> "${path}"
    lines="$(wc -l < "${path}" | tr -d ' ')"
    ! output=$(crun "${path}" 2>&1)
    echo "${output}" | grep ".c:${lines}:1:"
}
