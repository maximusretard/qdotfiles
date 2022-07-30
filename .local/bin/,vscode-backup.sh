#!/usr/bin/env bash

bak_folder="/home/$USER/.config/vscode-bak"
cfg_folder="/home/$USER/.config/Code/User"
ext_script="$bak_folder/install-extensions.sh"

rm -rf "$bak_folder"
mkdir "$bak_folder"
cp "$cfg_folder"/*.json "$bak_folder"

echo "#!/usr/bin/env bash" > "$ext_script"
echo "" >> "$ext_script"
code --list-extensions | xargs -L 1 echo code --install-extension >> "$ext_script"
chmod u+x "$ext_script"
