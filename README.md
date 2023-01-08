# Dotfiles

Dotfiles are managed by rcm and computer setup is manged by Ansible.

## Setup a new Ubuntu laptop

Perform a minimal Ubuntu install, then run this:

```
$ sudo apt-get update && \
  sudo apt-get upgrade && \
  sudo apt-get dist-upgrade && \
  sudo apt-get autoremove && \
  sudo apt-get install ansible git
$ cd /tmp && \
  git clone https://github.com/tbalthazar/ansible-roles && \
  git clone https://github.com/tbalthazar/dotfiles
$ ANSIBLE_ROLES_PATH=/tmp/ansible-roles ansible-playbook /tmp/dotfiles/laptop.yml -u tb -K
# logout/back in after zsh has been installed
$ ANSIBLE_ROLES_PATH=/tmp/ansible-roles ansible-playbook /tmp/dotfiles/laptop.yml -u tb -K
```

## Manage dotfiles

Update and install dotfiles managed by rcm (from dotfiles to home):

```
$ rcup -v
```

Add an existing dotfiles that's not yet managed by rcm (from home to dotfiles):

```
$ mkrc -t linux-desktop ~/.config/vlc/vlcrc
```

## Neovim

Main config is `~/.config/nvim/init.lua`, and is an unmodified version of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim).
Custom config is done in `~/.config/nvim/after/plugin/custom.lua`.
Additional plugins are configured in `~/.config/nvim/lua/custom/plugins.lua`.
