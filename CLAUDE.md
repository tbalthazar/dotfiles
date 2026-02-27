# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a personal dotfiles and laptop setup repository. It uses:
- **rcm** to manage dotfiles (symlink `~/.dotfiles/dotfiles/` into `$HOME`)
- **Ansible** to provision machines (install packages, configure tools)
- **bootstrap script** (`bin/bootstrap`) for first-time machine setup

## Structure

- `ansible/` — Ansible playbooks and roles
  - `playbooks/` — `full.yml` (desktop), `vm.yml` (VM), `wsl.yml` (WSL), `update.yml` (partial update)
  - `roles/` — one role per tool/app (base, dotfiles, neovim, mise, languages, docker, etc.)
- `bin/bootstrap` — first-run script: installs ansible/git, clones repo, runs a playbook
- `dotfiles/` — files managed by rcm; symlinked into `$HOME`
  - `tag-linux-desktop/` — files only applied with `-t linux-desktop`
  - `tag-linux-server/` — files only applied with `-t linux-server`
  - `bin/` — user scripts (installed to `~/.bin/`)

## Key Commands

### First-time machine setup (run once, then reboot)
```bash
# Debian desktop
wget -qO /tmp/bootstrap https://code.h.tb.io/tb/dotfiles/raw/branch/main/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap full

# VM
/tmp/bootstrap vm

# WSL (Ubuntu)
wget -qO /tmp/bootstrap https://raw.githubusercontent.com/tbalthazar/dotfiles/refs/heads/main/bin/bootstrap && chmod +x /tmp/bootstrap && /tmp/bootstrap wsl
```

### Apply Ansible playbooks without bootstrap
```bash
ansible-laptop full      # runs playbooks/full.yml from ~/.dotfiles/ansible/
ansible-laptop update    # runs playbooks/update.yml
```

### Update dotfiles after changes
```bash
update-dotfiles    # git pull + rcup for linux-desktop tag
```

### Manually run rcm to re-apply dotfiles
```bash
rcup -f -v -d ~/.dotfiles/dotfiles -t linux-desktop
```

## Ansible Conventions

- All playbooks run against `localhost` with `become: true`
- Default `user` variable is `tb` — set per-playbook in `vars:`
- `dotfiles_tag`, `dotfiles_repo`, `dotfiles_branch` are set in `roles/dotfiles/defaults/main.yml` and can be overridden per-playbook
- Role path for local dev: `ANSIBLE_ROLES_PATH=./roles` (set by `ansible-laptop` script)
- `ansible.cfg` in `dotfiles/` points to a separate infra repo — not used here

## rcm / Dotfiles Conventions

- Source of truth is `~/.dotfiles/` (cloned from this repo)
- Tags control which files are symlinked: `linux-desktop` vs `linux-server`
- `rcrc` files in each tag directory set `DOTFILES_DIRS` and `TAGS`
- To add a new dotfile: `mkrc -t linux-desktop ~/.config/somefile`

## Playbook Variants

| Playbook | Target | Notable roles included |
|----------|--------|----------------------|
| `full.yml` | Debian desktop | All roles including Docker, VirtualBox, Flatpak, GNOME |
| `vm.yml` | Debian VM | Base + dev tools (no GUI apps) |
| `wsl.yml` | Ubuntu WSL | Base + dev tools (no GUI apps) |
| `update.yml` | Any | Selective update: fzf, neovim, zellij, obsidian, kube-ps1, filen, proton-pass, opensnitch |
