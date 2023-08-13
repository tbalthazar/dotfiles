# Dotfiles

Dotfiles are managed by [rcm](https://github.com/thoughtbot/rcm) and computer setup is setup using a couple of basic bash scripts.

## Setup a new Debian 12 (Bookworm) laptop

Perform standard Debian install with Gnome and system utilities, then run this:

```bash
$ su
# apt-get update && apt-get install git && \
  git clone https://github.com/tbalthazar/dotfiles /tmp && \
  cd /tmp/dotfiles &&
  ./bin/setup-as-root.sh
# reboot now
```

then run, as `tb`:

```bash
$ cd ~ && \
  git clone https://github.com/tbalthazar/dotfiles ~/.dotfiles && \
  .dotfiles/bin/setup-as-tb.sh
```

Setup some global shortcuts:
- `ctrl+shift+space`: `1password --quick-access`
- `shift+super+q`: Windows > Close window

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
