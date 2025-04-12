#!/usr/bin/env bash

if [ "$EUID" -eq 0 ]
  then echo "Don't run this script as root."
  exit
fi

bindl=~/.bin-dl

echo "[+] Installing neovim..."
mkdir -p $bindl
nvim_appimage_name='nvim-linux-x86_64.appimage'
wget -q https://github.com/neovim/neovim/releases/download/stable/$nvim_appimage_name -O $bindl/$nvim_appimage_name
wget -q https://github.com/neovim/neovim/releases/download/stable/shasum.txt -O $bindl/shasum.txt

cd $bindl
sha256sum --ignore-missing -c shasum.txt
rm $bindl/shasum.txt
mv $bindl/$nvim_appimage_name $bindl/nvim.appimage
chmod +x nvim.appimage
ln -s nvim.appimage nvim
ln -s nvim.appimage vim
ln -s nvim.appimage vi
cd ~

echo "[+] Installing dotfiles..."
git clone https://github.com/tbalthazar/dotfiles ~/.dotfiles
rcup -v -f -d ~/.dotfiles/dotfiles -t linux-desktop

echo "[+] Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --completion --key-bindings --no-update-rc

echo "[+] Done."
