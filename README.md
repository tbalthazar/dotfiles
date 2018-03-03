# dotfiles

## Documentation

- [terminal](doc/terminal.md)
- [resolution](doc/resolution.md)

## Installation

Login as `root`:

```console
root$ apt-get update && apt-get dist-upgrade && apt-get install git su
root$ adduser tb sudo
root$ logout
```

Login as `tb`:
```console
user$ git clone https://github.com/tbalthazar/dotfiles.git && cd dotfiles
user$ sudo su
root$ bin/install setup
root$ exit
user$ bin/install dotfiles
user$ startx
user$ sudo su
root$ bin/install configure_system
root$ exit
user$ bin/install configure_user
```
