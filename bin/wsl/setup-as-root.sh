#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Run this script as root"
  exit
fi

username=tb

echo "[+] Updating packages..."
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

echo "[+] Adding $username to sudo group..."
/usr/sbin/usermod -aG sudo $username

echo "[+] Setting zsh as default shell..."
/usr/sbin/usermod -s /usr/bin/zsh $username

echo "[+] Installing additional packages..."
apt-get install -y \
      alacritty \
      ansible \
      build-essential \
      curl \
      exfat-fuse \
      git \
      htop \
      nnn \
      rcm \
      ripgrep \
      tmux \
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



echo "[+] Setup done, please reboot."
