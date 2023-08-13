#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Run this script as root"
  exit
fi

username=tb
debian_codename=bookworm

echo "[+] Adding $username to sudo group..."
/usr/sbin/usermod -aG sudo $username

echo "[+] Setting zsh as default shell..."
/usr/sbin/usermod -s /usr/bin/zsh $username

echo "[+] Removing some packages..."
apt-get purge -y \
  evolution

echo "[+] Installing additional packages..."
apt-get install -y \
      alacritty \
      ansible \
      build-essential \
      curl \
      exfat-fuse \
      git \
      hplip \
      htop \
      nextcloud-desktop \
      nnn \
      rcm \
      ripgrep \
      tmux \
      vlc \
      zsh

echo "[+] Installing dev dependencies..."
apt-get install -y \
	autoconf \
	bison \
	patch \
	build-essential \
	rustc \
	libssl-dev \
	libyaml-dev \
	libreadline6-dev \
	zlib1g-dev \
	libgmp-dev \
	libncurses5-dev \
	libffi-dev \
	libgdbm6 \
	libgdbm-dev \
	libdb-dev \
	uuid-dev

echo "[+] Installing 1Password..."
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | \
  tee /etc/apt/sources.list.d/1password.list
mkdir -p /etc/debsig/policies/AC2D62742012EA22/
curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
  tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
apt-get update && apt-get install -y 1password

echo "[+] Installing Virtualbox..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $debian_codename contrib" > /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | \
  gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
apt-get update && apt-get install -y virtualbox-7.0
/usr/sbin/usermod -aG vboxusers  $username

echo "[+] Setup done, please reboot."
