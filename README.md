# Dotfiles

Dotfiles are managed by [rcm](https://github.com/thoughtbot/rcm) and computer setup is setup using a couple of basic bash scripts.

## Setup a new Debian 12 (Bookworm) laptop

Perform standard Debian install with Gnome and system utilities. 

Switch to root:
```bash
su
```

Install all the things:
```bash
apt-get update && apt-get install -y git && \
  git clone https://github.com/tbalthazar/dotfiles /tmp/dotfiles && \
  cd /tmp/dotfiles && \
  ./bin/setup-as-root.sh
```

Reboot:
```bash
reboot now
```

Then run, as `tb`:
```bash
git clone https://github.com/tbalthazar/dotfiles /tmp/dotfiles && \
  /tmp/dotfiles/bin/setup-as-tb.sh
```

## Post-install tweaks

### Backup

- add this backup task using `crontab -e`: `30 9,12,19 * * * /home/tb/.bin/backup-laptop`

### Shortcuts

- `shift+super+q`: Windows > Close window

### VirtualBox

- File > Preferences > Input > Virtual Machine > Host Key Combination: `left ctrl + left alt`
- File > Preferences > Input > Extended Features > Auto Capture Keyboard: unckecked

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

Main config is `~/.config/nvim/init.lua`, and is a slightly modified version of [kickstart.nvim (at this specific commit)](https://github.com/nvim-lua/kickstart.nvim/commit/465d6f25c23dc6be27746b758253168adf9cb5bb). (Previous customizations can be seen in [this diff](https://github.com/tbalthazar/dotfiles/compare/4e04f0c3068614c7b04ffa83163b693a0b057f29..1c1fd21))

Additional plugins are configured in `~/.config/nvim/lua/custom/plugins/init.lua`.

Autoformat is managed by `stevearc/conform.nvim`. Current autoformatters can be seen with `:ConformInfo`.

Plugins are managed by Lazy, see `:Lazy`.

Mason is a package manager to install LSPs, Linters, ...: `:Mason`

Syntax Highlighting is done with TreeSitter: `:TSInstallInfo`
