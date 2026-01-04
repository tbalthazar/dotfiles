# Post Install

After installing a brand new copy of the OS and running the bootstrap script, some steps remain to be done manually.

## Credentials and SSH keys

Get API tokens for GitHub and Forgejo and set them in the `~/.netrc` file (with `chmod 0600`):
```
machine github.com
  login xxx
  password xxx
```

Create a `.ssh/config.private` file (with `chmod 0600`) from the saved template in Proton Pass.
Export SSH keys from Proton Pass and make sure to `chmod 0600` them.
```
id_ed25519
id_ed25519.pub
id_ed25519_bastion
id_ed25519_bastion.pub
```

## GNOME

In the Extension Manager app, make sure these extensions are enabled:
- Tactile
- Ubuntu App Indicators

In GNOME Tweaks, add Filen in the Startup Applications list.

## Firefox

Sign in to my Firefox account and make sure containers are synced. (Delete default containers)
In the Homelab container, add `socks://127.0.0.1:1080` as a Proxy configuration.

In uBlock Origin, block the "login with Google" iFrame. Go to uBlock preferences then my filters:
```
||accounts.google.com/gsi/iframe
```
---

## System

Get the `.zsh_history` from the backup.

Disable KVM kernel extensions to allow VirtualBox to run VMs. 
Either temporarily:
```
# check they're enabled
$ lsmod | grep kvm
kvm_intel             413696  0
kvm                  1396736  1 kvm_intel
irqbypass              12288  1 kvm

# disable them
$ sudo modprobe -r kvm_intel kvm

# check they're disabled
$ lsmod | grep kvm
```

To persist after reboot:
```
# create a blacklist file
sudo nano /etc/modprobe.d/blacklist-kvm.conf

# add
blacklist kvm
blacklist kvm_intel

# update initramfs and reboot
sudo update-initramfs -u
sudo reboot
```
