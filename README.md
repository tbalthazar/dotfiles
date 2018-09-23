# dotfiles

## Documentation

- [terminal](doc/terminal.md)
- [resolution](doc/resolution.md)

## Installation

Login as `root`:

```bash
root$ apt-get update && apt-get dist-upgrade && apt-get install git sudo
root$ adduser tb sudo
root$ logout
```

Login as `tb`:
```bash
user$ git clone https://github.com/tbalthazar/dotfiles.git && cd dotfiles
user$ sudo su
# if running in VirtualBox
root$ bin/install setup_virtualbox && reboot
root$ bin/install setup
root$ exit
user$ bin/install dotfiles
# if startx fails, try installing the guest additions from the VirtualBox Devices menu.
# in the virtual machine, sudo mount /media/cdrom
# then sh /media/cdrom/VBoxLinuxAdditions.sh then reboot
user$ startx
# at this point, Termite is not installed yet, use xterm
user$ sudo su
root$ bin/install configure_system
root$ exit
user$ bin/install configure_user
```

## Notes

- solution for xbacklight: https://unix.stackexchange.com/questions/301724/xbacklight-not-working and https://wiki.archlinux.org/index.php/backlight#Overview
- set default release for apt: https://unix.stackexchange.com/a/253866  
- show the source of an installed package:
  - get info for that package `dpkg -s <package>`
  - show available versions and the source for each version: `apt-cache showpkg <package>`
- configure trackpad: https://unix.stackexchange.com/a/396357 and https://wiki.archlinux.org/index.php/Libinput#Button_re-mapping
- terminte install script: https://github.com/Corwind/termite-install
- termite themes: https://github.com/khamer/base16-termite/tree/master/themes
- change keyboard layout: `setxkbmap be`
