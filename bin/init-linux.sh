#!/bin/bash

set -e

# Install base packages
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y \
  adduser \
  curl \
  git \
  gnupg2 \
  htop \
  tmux \
  vim-gtk \
  vim-nox \
  wget \
  xclip \
  --no-install-recommends

printf "\n\n-- base package installed\n\n"

# Install rcm
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm

printf "\n\n-- rcm installed\n\n"

# Init rcm
rcup -v -d $HOME/.dotfiles/dotfiles -t linux

printf "\n\n-- dotfiles installed\n\n"

# Tmux theme
mkdir -p $HOME/.tmux/themes
git clone https://github.com/arcticicestudio/nord-tmux $HOME/.tmux/themes/nord-tmux

printf "\n\n-- tmux theme installed\n\n"

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install --completion --key-bindings --no-update-rc

printf "\n\n-- fzf installed\n\n"

# Install zsh
sudo apt-get update && sudo apt-get -y install zsh
chsh -s /bin/zsh

printf "\n\n-- zsh installed. Please log out and log back in.\n\n"

