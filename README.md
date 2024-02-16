# Dotfiles

Dotfiles are managed by [rcm](https://github.com/thoughtbot/rcm) and computer setup is setup using a couple of basic bash scripts.

## Setup a new Debian 12 (Bookworm) laptop

Perform standard Debian install with Gnome and system utilities, then run this:

```bash
$ su
# apt-get update && apt-get install -y git && \
  git clone https://github.com/tbalthazar/dotfiles /tmp/dotfiles && \
  cd /tmp/dotfiles &&
  ./bin/setup-as-root.sh
# reboot now
```

then run, as `tb`:

```bash
$ git clone https://github.com/tbalthazar/dotfiles /tmp/dotfiles && \
  /tmp/dotfiles/bin/setup-as-tb.sh
```

## Post-install tweaks

### Shortcuts

- `shift+super+q`: Windows > Close window

### VirtualBox

- File > Preferences > Input > Virtual Machine > Host Key Combination: `left ctrl + left alt`

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

Main config is `~/.config/nvim/init.lua`, and is a slightly modified version of [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/commit/98ad2ee32adea1a02b06a4b45c16fb6f11d836b9).
Additional plugins are configured in `~/.config/nvim/lua/custom/plugins/init.lua`.
