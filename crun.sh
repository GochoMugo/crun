#!/usr/bin/env bash

# stop on error
set -e

# crun metadata
CRUN_VERSION="0.6.0"
CRUN_URL="https://github.com/GochoMugo/crun"

# showing help information
function show_help() {
    echo " usage:"
    echo "    as a shebang in your C file: #!/usr/bin/env crun"
    echo "    direct invocation:"
    echo "          crun --create|create-force <path>"
    echo "          crun --help|version"
    echo "          crun [--<option>] filename.c"
    echo
    echo " options:"
    echo "    -c,  --create        create a template script"
    echo "    -cf, --create-force  same as '-c', but allow overwriting"
    echo "    -de, --do-eval       enable bash eval"
    echo "    -fc, --force-compile compile script, regardless..."
    echo "    -jc, --just-compile  compile script and stop"
    echo "    -h,  --help          show this help information and exit"
    echo "    -v,  --version       show version information"
    echo
    echo " see ${CRUN_URL} for feature requests and bug reporting"
    echo
}


# simple templating for a new C file
# ${1} - file path
# ${2} - whether to force creation i.e. clobber
function new() {
    local force="${2:-}"

    if [ ! "${1}" ]
    then
        echo "ERROR: NO path provided"
        return 1
    fi

    if [ -f "${1}" ]
    then
        echo "WARNING: file found at '${1}'"
        if [ ! "${force}" ]
        then
            echo "ERROR: stopping to avoid overwriting existing file"
            echo "ERROR: use '--create-force' to force clobbering"
            return 1
        else
            echo "WARNING: file overwritten"
        fi
    fi

    {
        echo "#!/usr/bin/env crun"
        echo "/* -Wall -O3 */"
        echo
        echo "int main(void) {"
        echo "  return 0;"
        echo "}"
    } > "${1}"
    chmod u+x "${1}"
}


INPUT_FILENAME=
INPUT_DO_EVAL=false
INPUT_FORCE_COMPILE=false
INPUT_JUST_COMPILE=false
INPUT_XARGS=


# processing environment variables
if [ -n "${CRUN_DO_EVAL}" ]
then
    INPUT_DO_EVAL=true
fi


# some arguments processing
for arg in "${@}"
do
case ${arg} in
    "-v" | "--version" )
        echo ${CRUN_VERSION}
        exit
    ;;
    "-h" | "--help" )
        show_help
        exit
    ;;
    "-c" | "--create" )
        new "${2}"
        exit $?
    ;;
    "-cf" | "--create-force" )
        new "${2}" "force"
        exit $?
    ;;
    "-de" | "--do-eval" )
        INPUT_DO_EVAL=true
    ;;
    "-fc" | "--force-compile" )
        INPUT_FORCE_COMPILE=true
    ;;
    "-jc" | "--just-compile" )
        INPUT_JUST_COMPILE=true
    ;;
    * )
        if [ -z "${INPUT_FILENAME}" ]
        then
            INPUT_FILENAME=${arg}
        else
            INPUT_XARGS="${INPUT_XARGS} ${arg}"
        fi
    ;;
esac
done


# ensure we have a path to an existing source file
[ -f "${INPUT_FILENAME}" ] || {
    echo " ERROR: NO regular file at the path provided"
    echo
    show_help
    exit 1
}


# global vars
ARGV=${INPUT_XARGS}
MAIN_DIR=$(readlink -f "$(dirname "${INPUT_FILENAME}")")

FILENAME=$(basename "${INPUT_FILENAME}")
ABS_PATH="${MAIN_DIR}/${FILENAME}"
OUT_DIR="${CRUN_CACHE_DIR:-/tmp/crun}"
OUT_NAME="$(echo "${ABS_PATH}" | sed s'/\//./g')"
OUT_EXE="${OUT_DIR}/${OUT_NAME}"
TMP_FILE="${OUT_EXE}.tmp.c"
CC_FLAGS="$(sed '2!d' "${ABS_PATH}" | grep -Eo '\/\*.*\*\/' | sed -e s'/^\/\*//' -e s'/\*\/$//')"

# runs the executable
function run_exe() {
    "${OUT_EXE}" ${ARGV}
    exit $?
}

# compiles code
# ${1} - path to file with source code
# ${2} - path to place executable
function compile() {
    local args=

    # chdir to the directory holding the file
    pushd "${MAIN_DIR}" > /dev/null

    # if eval is enabled, do so
    if [ "${INPUT_DO_EVAL}" == true ]
    then
        args=$(eval "echo $CC_FLAGS")
    else
        args="${CC_FLAGS}"
    fi

    # if we are just compiling, then the args are for compilation
    if [ "${INPUT_JUST_COMPILE}" == true ]
    then
        args="${args} ${INPUT_XARGS}"
    fi

    # do compilation
    cc -o "${2}" "${1}" -I"${MAIN_DIR}" -L"${MAIN_DIR}" ${args}

    popd > /dev/null
}


# ensure our out directory exists
mkdir -p "${OUT_DIR}"

# if it is already compiled (recent enough), run the executable
if [ "${INPUT_FORCE_COMPILE}" == false ] && \
   [ -e "${OUT_EXE}" ] && \
   [ "${OUT_EXE}" -nt "${ABS_PATH}" ] && \
   [ "${INPUT_JUST_COMPILE}" == false ] ; then
    run_exe
fi

# strip out the 1st line (contains the shebang)
tail -n +2 "${ABS_PATH}" > "${TMP_FILE}.tmp"
echo | cat - "${TMP_FILE}.tmp" > "${TMP_FILE}"

# remove the CC_FLAGS
if [ "${CC_FLAGS}" ]
then
    tail -n +3 "${TMP_FILE}" > "${TMP_FILE}.tmp"
    echo | cat - "${TMP_FILE}.tmp" > "${TMP_FILE}.tmp1"
    echo | cat - "${TMP_FILE}.tmp1" > "${TMP_FILE}"
fi

# compile the file
compile "${TMP_FILE}" "${OUT_EXE}"

# remove the temp file
rm "${TMP_FILE}"*

# run the executable, if we are NOT just compiling. Otherwise, echo
# the path to the executable
if [ "${INPUT_JUST_COMPILE}" == false ]
then
    run_exe
else
    echo "${OUT_EXE}"
fi
