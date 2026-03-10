# Dotfiles

Dotfiles are managed by [rcm](https://github.com/thoughtbot/rcm) and computer setup is automated using [Ansible](https://docs.ansible.com/).

## First-time Setup

Run the bootstrap script once on a fresh machine, then reboot.

### Debian 13 (Trixie) laptop

```bash
wget -qO /tmp/bootstrap https://code.h.tb.io/tb/dotfiles/raw/branch/main/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap full
```

### Debian 13 (Trixie) VM

```bash
wget -qO /tmp/bootstrap https://code.h.tb.io/tb/dotfiles/raw/branch/main/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap vm
```

### Ubuntu 24.04 under WSL

```bash
wget -qO /tmp/bootstrap https://raw.githubusercontent.com/tbalthazar/dotfiles/refs/heads/main/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap wsl
```

## Day-to-day Commands

After the initial bootstrap, use `dotfiles-cli` for common operations:

```bash
dotfiles-cli help               # show all available commands
dotfiles-cli update             # pull latest changes and re-apply dotfiles
dotfiles-cli apply full         # re-run the full Ansible playbook
dotfiles-cli apply update       # run only the update playbook
dotfiles-cli add ~/.config/foo  # add a file to dotfiles (rcm, linux-desktop tag)
dotfiles-cli status             # show git status of the dotfiles repo
dotfiles-cli edit               # open the dotfiles repo in your editor
```

The legacy commands still work too:

```bash
ansible-laptop full      # run an Ansible playbook
update-dotfiles          # pull + re-apply dotfiles
```

## Ansible Playbooks

| Playbook | Target | Description |
|----------|--------|-------------|
| `full`   | Debian desktop | All roles including Docker, VirtualBox, Flatpak, GNOME tweaks |
| `vm`     | Debian VM | Same as full minus VirtualBox (uses GitHub as dotfiles repo) |
| `wsl`    | Ubuntu WSL | Base + dev tools only (no GUI apps) |
| `update` | Any | Update selected tools: fzf, neovim, helix, zellij, obsidian, etc. |

## Documentation

- [Neovim](docs/neovim.md)
- [Post-install notes](docs/post-install.md)

---

## Before Re-installing

- Backup uBlock Origin config
- Backup Obsidian Clipper Templates

## Post-install Tweaks

- [See Post-install notes](docs/post-install.md)

### Backup

- Add this backup task using `crontab -e`:
  ```
  30 9,12,19 * * * /home/tb/.bin/backup-laptop > /tmp/backup-cron.log 2>&1
  ```

## Manage Dotfiles

Add an existing file that's not yet managed by rcm:

```bash
dotfiles-cli add ~/.config/vlc/vlcrc

# or directly with rcm:
mkrc -t linux-desktop ~/.config/vlc/vlcrc
```

## WSL / Windows Terminal

- Windows Terminal > Settings > Actions: delete the `ctrl+v` shortcut (as it interferes with vim)
