# dotfiles

## Installation

```
git clone git@github.com:tbalthazar/dotfiles.git
cd dotfiles
./install.sh
```

The `install.sh` script will first backup your existing dotfiles in `~/.dotfiles-backup/timestamp` before installing the new ones.

## Private config

You can place some private configurations in `~/.bash_profile.private`. If this file exists, it will be sourced in `.bash_profile`.

Example :
```
git config --global user.name "John Doe"
git config --global user.email "example@example.com"
```

## Credits

Inspired by https://github.com/necolas/dotfiles.
