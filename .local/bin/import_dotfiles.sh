#!/bin/sh

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
git clone --bare https://github.com/maximusretard/qdotfiles.git $HOME/.dotfiles
function dotfiles {
   /usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}
mkdir -p .dotfiles-backup
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dotfiles.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
xrdb merge ~/.Xresources
