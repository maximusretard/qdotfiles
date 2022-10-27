#!/usr/bin/env bash

####################################################################
#				CONFIG				   #
####################################################################
# If a command fails, exit immediately instead of continuing script
set -o errexit
# Fail if trying to access unset variable
set -o nounset
# Fail pipeline command if any command in the pipeline fails
set -o pipefail
# Allows running in debug mode with `TRACE=1 ./script.sh`
if [[ "${TRACE-0}" == "1" ]]; then
    set -o xtrace
fi

# Uncomment if must be run as root
#[[ $EUID = 0 ]] || { echo "Must be run as root" >&2; exit 1; }

# Switch to directory where script source file is located
cd "$( dirname "${BASH_SOURCE[0]}" )"

####################################################################
#				ARGUMENTS			   #
####################################################################
# Help message
if [[ "${1-}" =~ ^-*h(elp)?$ ]]; then
    echo 'Usage: ./script.sh arg-one arg-two

This is an awesome bash script to make your life better.

'
    exit
fi


####################################################################
#				SCRIPT				   #
####################################################################
main() {
    echo 'do awesome stuff'
}

main "$@"
