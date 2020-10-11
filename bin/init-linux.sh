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
  zsh \
  --no-install-recommends

printf "\n\n-- base package installed\n\n"

# Install rcm
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm

printf "\n\n-- rcm installed\n\n"

# Init rcm
rcup -v -d $HOME/.dotfiles/dotfiles -t linux-desktop

printf "\n\n-- dotfiles installed\n\n"

# Tmux theme
tmux_themes_dir=$HOME/.tmux/themes
tmux_theme_dir=$tmux_themes_dir/nord-tmux
tmux_theme_repo=https://github.com/arcticicestudio/nord-tmux
mkdir -p $tmux_themes_dir
if [ -d $tmux_theme_dir ]; then
  cd $tmux_theme_dir && git pull 
else
  git clone $tmux_theme_repo $tmux_theme_dir
fi

printf "\n\n-- tmux theme installed\n\n"

# Install fzf
fzf_dir=$HOME/.fzf
if [ -d $fzf_dir ]; then
  cd $fzf_dir && git pull
else
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
fi
$HOME/.fzf/install --completion --key-bindings --no-update-rc

printf "\n\n-- fzf installed\n\n"

# Install vim plugins
# TODO: seems to block, to investigate
#vim -es -u $HOME/.vimrc -i NONE -c "PlugInstall" -c "qa"

#printf "\n\n-- vim plugins installed\n\n"

# Install zsh
chsh -s /bin/zsh

printf "\n\n-- zsh installed. Please log out and log back in.\n\n"
