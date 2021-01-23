# Dotfiles

## Setup

```
$ git clone https://github.com/tbalthazar/dotfiles ~/.dotfiles
$ ~/.dotfiles/bin/init-linux.sh
```

## Update and install dotfiles managed by rcm

```
$ rcup -v
```

## Ansible notes

```
$ sudo apt-get update && sudo apt-get upgrade && sudo apt-get install ansible git
$ git clone https://github.com/tbalthazar/ansible-roles /tmp/ansible-roles
$ ANSIBLE_ROLES_PATH=/tmp/ansible-roles ansible-playbook laptop.yml -u tb
```
