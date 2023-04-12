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
    echo "Usage: ./$0 theme-value"
    echo '
    Set gtk-3.0 & gtk-4.0 theme to dark (1) or light (0)

'
    exit
fi


####################################################################
#				SCRIPT				   #
####################################################################
set_dark_theme() {
    local file_path="$1"
    local theme_value="$2"

    # Create the directory if it doesn't exist
    mkdir -p "$(dirname "$file_path")"

    # Check if the file exists
    if [ ! -f "$file_path" ]; then
        # If the file does not exist, create it with the content
        echo -e "[Settings]\ngtk-application-prefer-dark-theme=$theme_value" > "$file_path"
    else
        # Check if the file has the [Settings] section
        if ! grep -q "^\[Settings\]$" "$file_path"; then
            # If it doesn't, add the settings section
            echo -e "\n[Settings]\ngtk-application-prefer-dark-theme=$theme_value" >> "$file_path"
        else
            # Check if the file has the gtk-application-prefer-dark-theme=n line
            if ! grep -q "^gtk-application-prefer-dark-theme=" "$file_path"; then
                # If it doesn't, add the line under the [Settings] section
                sed -i "/^\[Settings\]$/\[Settings\]\ngtk-application-prefer-dark-theme=$theme_value" "$file_path"
            else
                # If it does, change the line to gtk-application-prefer-dark-theme=1
                sed -i "s/^gtk-application-prefer-dark-theme=.*/gtk-application-prefer-dark-theme=$theme_value/" "$file_path"
            fi
        fi
    fi
}

main() {
	if [ $# -ne 1 ]; then
		echo "Usage: $0 theme-value"
		exit 1
	fi

	value=$1
	# Validate
	if [ "$value" != "1" ] && [ "$value" != "0" ]; then
		echo "Error: Theme value must be '1' or '0'"
		exit 1
	fi

	# Run scripts
	set_dark_theme "${HOME}/.config/gtk-3.0/settings.ini" $value
	set_dark_theme "${HOME}/.config/gtk-4.0/settings.ini" $value
}

main "$@"
