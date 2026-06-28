#!/bin/sh

# Default xetex compiler directories
AUX_DIR="./aux"
OUT_DIR="./output"
SVG_DIR="./svg-inkscape"

# Markdown directories
MD_DIR="./markdown"
IN_DIR="./"

# Styles directories
STYLES_DIR=./assets/styles
STYLE=riceamasters

function_scope_cleaner() {

    # unsets FUNCTION_SCOPE
    FUNCTION_SCOPE=""
    unset FUNCTION_SCOPE

}

pretty_printer() {
    # will always run because the script can only run if the pretty-printer was user-defined.
    if ! [ "${PDFBUILDER_VERBOSE}" = "1" ]; then
        echo "|> [WARNING]: the [PDFBUILDER_VERBOSE] pretty-printer variable was not set. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully found the [PDFBUILDER_VERBOSE] environment variable. Proceeding..."

    echo
    echo "==================="
    echo "|> Function scope: ${FUNCTION_SCOPE}"
    echo
}

clean() {

    # check if AUX_DIR exists, remove AUX_DIR.
    if ! ls -allhtr "${AUX_DIR}"; then
        echo "|> [ERROR]: AUX_DIR not found. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: found an AUX_DIR directory. Proceeding..."

    if ! rm -rf "${AUX_DIR}"; then
        echo "|> [ERROR]: could not remove [AUX_DIR=${AUX_DIR}]. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully removed [AUX_DIR]. Proceeding..."

    # check if OUT_DIR exists, remove OUT_DIR.
    if ! ls -allhtr "${OUT_DIR}"; then
        echo "|> [ERROR]: OUT_DIR not found. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: found an OUT_DIR directory. Proceeding..."

    if ! rm -rf "${OUT_DIR}"; then
        echo "|> [ERROR]: could not remove [OUT_DIR=${OUT_DIR}]. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully removed [OUT_DIR=${OUT_DIR}]. Proceeding..."

    # check if SVG_DIR exists, remove SVG_DIR.
     if ! ls -allhtr "${SVG_DIR}"; then
        echo "|> [ERROR]: SVG_DIR not found. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: found an SVG_DIR directory. Proceeding..."

    if ! rm -rf "${SVG_DIR}"; then
        echo "|> [ERROR]: could not remove [SVG_DIR=${SVG_DIR}]. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully removed [SVG_DIR=${SVG_DIR}]. Proceeding..."

}


### ALWAYS_IDEMPOTENT
create_dirs() {
    ## Create aux directory
    if ! [ -d "./aux" ]; then
        mkdir -p "./aux"
    fi
    echo "|> [./aux] directory created with success. Proceeding..."

    ## Create svg directory
    if ! [ -d "./svg" ]; then
        mkdir -p "./svg"
    fi
    echo "|> [./svg] directory created with success. Proceeding..."

    ## Create output directory
    if ! [ -d "./output" ]; then
        mkdir -p "./output"
    fi
    echo "|> [./output] directory created with success. Proceeding..."
}




xelatex_version() {

    # Define function scope for Function [pretty-printer]
    FUNCTION_SCOPE="XELATEX_VERSION"

    pretty_printer

    xelatex -v
    echo
    echo "==================="
    echo && echo

    # Cleans up the function scope for Function [pretty-printer]
    function_scope_cleaner


}

xelatex_pdf() {
    TEXFILE_TO_INGEST="./ppgec-abntex2-modelo.tex"
    IN_BETWEEN_BUILD_ART="./artifacts/buildaxela.sh"

    # Define function scope for Function [pretty-printer]
    FUNCTION_SCOPE="XELATEX_PDF"
    pretty_printer

    # Create ./output, ./aux, ./svg directories
    if ! create_dirs; then
        echo "|> [Error]: It was not possible to create directories before compiling. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully created directories before compiling. Proceeding..."

    # Print xelatex version
    if ! xelatex_version; then
        echo "|> [ERROR]: it was not possible to print xelatex version. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully printed xelatex version. Proceeding..."

    # Create the in-between file
    mkdir -p "./artifacts"
    if ! (
        (
    cat <<EOF

    #!/bin/sh

    xelatex -interaction=nostopmode -file-line-error -shell-escape -recorder -output-directory="aux"  "${TEXFILE_TO_INGEST}")

EOF
) | tee ${IN_BETWEEN_BUILD_ART}); then
    echo "|> [Error]: It was not possible to create [${IN_BETWEEN_BUILD_ART}]. Exiting now..."
    return 1
    fi
    echo "|> [PASS]: successfully created [${IN_BETWEEN_BUILD_ART}]. Proceeding..."
    echo

    # Run in-between file
    if ! /bin/sh -c ${IN_BETWEEN_BUILD_ART} ; then
        echo "|> [Error]: It was not possible to compile .tex files using xelatex. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: there were no errors raised by the xelatex compiler. Proceeding..."

    # Check if file was succesffully generated
    if ! ls -allhtr "${TEXFILE_TO_INGEST}"; then
        echo "|> [ERROR]: the file [TEXFILE_TO_INGEST=${TEXFILE_TO_INGEST}] was not found at the provided path. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully compiled the .tex file and created a .PDF file with xelatex. Proceeding..."


    # Cleans up the function scope for Function [pretty-printer]
    function_scope_cleaner

}

pandoc_clipdf() {
    # Define function scope for Function [pretty-printer]
    FUNCTION_SCOPE="XELATEX_PDF"
    pretty_printer

    if ! (
        pandoc --version \
        | head -1 \
        | cut -d ' ' -f2 \
        | cut -d '.' -f1 \
        > ./artifacts/pandoc-version.txt
    ); then
    echo "|> [ERROR]: could not print pandoc version. Exiting now..."
    return 1
    fi

    if ! ls -allhtr ./artifacts/pandoc-version.txt; then
        echo "|> [ERROR]: file [./artifacts/pandoc-version.txt] does not exist. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: successfully found the file [./artifacts/pandoc-version.txt]. Proceeding..."
    PANDOC_VERSION=$(cat ./artifacts/pandoc-version.txt)

    rm ./artifacts/pandoc-version.txt

    if [ "${PANDOC_VERSION}" -eq "2" ]; then
        SMART=-smart;
    else
        SMART=--smart;
    fi

    # Cleans up the function scope for Function [pretty-printer]
    function_scope_cleaner

}

print_usage() {
    cat <<-END >&2
USAGE: pdfbuilder.sh [-options]
                - clean
                - xelatex_pdf
                - version
                - help
eg,
MODE="clean"        . ./scripts/pdfbuilder.sh   # clean intermediate compiler files
MODE="xelatex_pdf"  . ./scripts/pdfbuilder.sh   # compile the .tex project with xelatex and create a pdf.
MODE="version"      . ./scripts/pdfbuilder.sh   # shows script version
MODE="help"         . ./scripts/pdfbuilder.sh   # shows this help message

See the man page and example file for more info.

END

}

# Check the argument passed from the command line
if ! [ -z "${PDFBUILDER_VERBOSE}" ] && [ "${PDFBUILDER_VERBOSE}" = "1" ]; then
    PDFBUILDER_VERBOSE="1" && export PDFBUILDER_VERBOSE;

    if ! env | grep "PDFBUILDER_VERBOSE"; then
        echo "|> [WARNING]: the [PDFBUILDER_VERBOSE] pretty-printer variable was not set. Exiting now..."
        return 1
    fi
    echo "|> [PASS]: the [PDFBUILDER_VERBOSE] pretty-printer variable was set with success. Proceeding..."
fi

if ! [ -z "${MODE}" ] &&
    [ "${MODE}" = "clean" ] ||
    [ "${MODE}" = "xelatex_version" ] ||
    [ "${MODE}" = "xelatex_pdf" ] ||
    [ "${MODE}" = "help" ] ||
    [ "${MODE}" = "version" ]; then
    case "${MODE}" in
    "clean") clean ;;
    "xelatex_version") xelatex_version ;;
    "xelatex_pdf") xelatex_pdf ;;
    *)
        echo "Invalid option. Please specify one of: clean, xelatex_pdf"
        print_usage
        ;;
    esac

elif [ "${MODE}" = "help" ] || [ "${MODE}" = "-h" ] || [ "${MODE}" = "--help" ]; then
    print_usage
elif [ "${MODE}" = "version" ] || [ "${MODE}" = "-v" ] || [ "${MODE}" = "--version" ]; then
    printf "\n|> Version: pdfbuilder 1.0.0"
else
    echo "Invalid option. Please specify one of: clean, xelatex_pdf"
    print_usage
fi

