#!/usr/bin/env bash

bak_folder="/home/$USER/.config/vscode-bak"
cfg_folder="/home/$USER/.config/Code/User"

if [ ! -d "$cfg_folder" ]; then
  mkdir -p "$cfg_folder"
fi

cp "$bak_folder"/*.json "$cfg_folder"

. "$bak_folder/install-extensions.sh"
