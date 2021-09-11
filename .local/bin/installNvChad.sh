#!/usr/bin/env bash

rm -rf ~/.config/nvim
git clone https://github.com/maximusretard/NvChad ~/.config/nvim
cd ~/.config/nvim
git checkout retardmods
rm ~/.config/nvim/lua/chadrc.lua
ln -s ~/.config/nvchad/chadrc.lua ~/.config/nvim/lua/chadrc.lua
nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
