# Dotfiles

Dotfiles are managed by [rcm](https://github.com/thoughtbot/rcm) and computer setup is setup using Ansible.

## Setup a new Debian 13 (Trixie) laptop

Run this script the first time, then reboot. It should only be run once.

```bash
wget -qO /tmp/bootstrap https://code.h.tb.io/tb/dotfiles/raw/branch/tb/2025/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap
```

## Setup a new Ubuntu 24.04 under WSL

Run this script the first time, then reboot. It should only be run once.

```bash
wget -qO /tmp/bootstrap https://code.h.tb.io/tb/dotfiles/raw/branch/tb/2025/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap wsl
```

## Update dotfiles

To update dotfiles (e.g: when a new dotfile is added in `.dotfiles`), run:

```bash
update-dotfiles
```

## Update laptop with Ansible playbook

Run (it defaults to "update"):

```bash
ansible-laptop full|update|wsl
```


-----------------------------------


## Post-install tweaks

### Backup

- add this backup task using `crontab -e`: `30 9,12,19 * * * /home/tb/.bin/backup-laptop > /tmp/backup-cron.log 2>&1`


## Manage dotfiles

Add an existing dotfiles that's not yet managed by rcm (from home to dotfiles):

```
$ mkrc -t linux-desktop ~/.config/vlc/vlcrc
```

## WSL / Windows Terminal

- Windows Terminal > Settings > Actions: delete the `ctrl+v` shortcut (as it interferes with vim)
