#!/usr/bin/env bash

cd /tmp
tag=$(curl -s https://api.github.com/repos/kdheepak/taskwarrior-tui/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
wget "https://github.com/kdheepak/taskwarrior-tui/releases/download/${tag}/taskwarrior-tui-x86_64-unknown-linux-gnu.tar.gz"
mkdir -p ~/.local/share/taskwarrior-tui
tar -xzf taskwarrior-tui-x86_64-unknown-linux-gnu.tar.gz -C ~/.local/share/taskwarrior-tui taskwarrior-tui
rm -f taskwarrior-tui-x86_64-unknown-linux-gnu.tar.gz
ln -s ~/.local/share/taskwarrior-tui/taskwarrior-tui ~/.local/bin/tt

