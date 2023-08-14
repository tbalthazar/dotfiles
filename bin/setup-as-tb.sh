#!/usr/bin/env bash

if [ "$EUID" -eq 0 ]
  then echo "Don't run this script as root."
  exit
fi

bindl=~/.bin-dl

echo "[+] Installing neovim..."
mkdir -p $bindl
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O $bindl/nvim.appimage
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage.sha256sum -O $bindl/nvim.appimage.sha256sum
cd $bindl
sha256sum -c nvim.appimage.sha256sum
rm $bindl/nvim.appimage.sha256sum
chmod +x nvim.appimage
ln -s nvim.appimage nvim
ln -s nvim.appimage vim
ln -s nvim.appimage vi
cd ~

echo "[+] Installing dotfiles..."
git clone https://github.com/tbalthazar/dotfiles ~/.dotfiles
rcup -v -d ~/.dotfiles/dotfiles -t linux-desktop

echo "[+] Installing asdf..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
. "$HOME/.asdf/asdf.sh"
for plugin in golang ruby kubectl terraform; do
  echo "[+] Installing $plugin with asdf..."
  asdf plugin add $plugin
  asdf install $plugin latest
  asdf global $plugin latest
done

echo "[+] Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --completion --key-bindings --no-update-rc

echo "[+] Done."
