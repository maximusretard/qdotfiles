#!/usr/bin/env bash

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup"

#FUNCTIONS
mvConfig() {
   local FILEPATH=$1
   local DIR=$(dirname -- "$FILEPATH")
   echo "[DEBUG]: move_config $FILEPATH"
   if [ "$DIR" != "." ] && [ "$DIR" != "/" ]; then
      mkdir -p "${BACKUP_DIR}/${DIR}"
   fi
   mv "$FILEPATH" "${BACKUP_DIR}/${FILEPATH}"
}

#get fonts
mkdir -p ~/.local/share/fonts
cd ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Mononoki.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/InconsolataGo.zip
sudo unzip Mononoki.zip -d ~/.local/share/fonts/mononoki
sudo unzip SourceCodePro.zip -d ~/.local/share/fonts/saucecodepro
sudo unzip InconsolataGo.zip -d ~/.local/share/fonts/inconsolatago

#get dotfiles
cd ~/
git clone --bare https://github.com/maximusretard/qdotfiles.git $DOTFILES_DIR
function dotfiles {
   /usr/bin/git --git-dir="$DOTFILES_DIR/" --work-tree="$HOME" "$@"
}
mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dotfiles.";
    for file in $(dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'}); do
    	mvConfig "$file"
    done
fi;
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
xrdb merge ~/.Xresources
