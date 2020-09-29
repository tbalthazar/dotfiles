#!/bin/bash

set -e

# Install rcm
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm

printf "\n\n-- rcm installed\n\n"

# Init rcm
rcup -d $HOME/.dotfiles/dotfiles -t linux

printf "\n\n-- rcm configured\n\n"

# Install zsh
sudo apt-get update && sudo apt-get -y install zsh
chsh -s /bin/zsh

printf "\n\n-- zsh installed. Please log out and log back in.\n\n"

