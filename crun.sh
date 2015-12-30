#!/usr/bin/env bash

# stop on error
set -e

# ensure we have a path to an existing source file
[ -f "${1}" ] || {
    echo " usage:"
    echo "    as a shebang in your C file: #!/usr/bin/env crun"
    echo "    direct invocation:           crun filename.c"
    exit 1
}

# global vars
MAIN_DIR=$(dirname ${1})

# this ensure we always use an absolute path when we do
# './filename'
[ "${MAIN_DIR}" == "." ] && MAIN_DIR=$(pwd)

FILENAME=$(basename ${1})
ABS_PATH="${MAIN_DIR}/${FILENAME}"
OUT_DIR="/tmp/crun/"
OUT_NAME="$(echo ${ABS_PATH} | sed s'/\//./g')"
OUT_EXE="${OUT_DIR}/${OUT_NAME}"
TMP_FILE="${OUT_EXE}.tmp.c"

# runs the executable
function run_exe() {
    ${OUT_EXE}
    exit $?
}

# compiles code
# ${1} - path to file with source code
# ${2} - path to place executable
function compile() {
    cc -o ${2} ${1}
}

# ensure our out directory exists
mkdir -p ${OUT_DIR}

# if it is already compiled (recent enough), run the executable
if [ -e "${OUT_EXE}" ] && [ "${OUT_EXE}" -nt "${ABS_PATH}" ] ; then
    run_exe
fi

# chdir to the directory holding the file
cd ${MAIN_DIR}

# strip out the 1st line (contains the shebang)
tail -n +2 "${FILENAME}" > ${TMP_FILE}

# compile the file
compile ${TMP_FILE} ${OUT_EXE}

# remove the temp file
rm ${TMP_FILE}

# run the executable
run_exe

