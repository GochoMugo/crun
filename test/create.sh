#!/usr/bin/env bash
# testing the '--create' and '--create-force' option

path="${BATS_TMPDIR}/sample.c"

function teardown() {
    rm "${path}"
}

@test "--create: creates a template file" {
    crun --create "${path}"
    [ -f "${path}" ]
}

@test "--create: created file is executable" {
    crun --create "${path}"
    [ -x "${path}" ]
}

@test "--create: created file compiles right" {
    crun --create "${path}"
    crun "${path}"
}

@test "--create: errors if file exists" {
    touch "${path}"
    ! crun --create "${path}"
}

@test "--create-force: allows overwriting file" {
    touch "${path}"
    crun --create-force "${path}"
    crun "${path}"
}
