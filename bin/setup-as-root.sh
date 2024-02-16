#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Run this script as root"
  exit
fi

username=tb
debian_codename=bookworm

echo "[+] Updating packages..."
apt-get update && apt-get dist-upgrade -y && apt-get autoremove -y

echo "[+] Adding $username to sudo group..."
/usr/sbin/usermod -aG sudo $username

echo "[+] Setting zsh as default shell..."
/usr/sbin/usermod -s /usr/bin/zsh $username

echo "[+] Removing some packages..."
apt-get purge -y \
  evolution \
  transmission-gtk

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
      nnn \
      rcm \
      ripgrep \
      tmux \
      wl-clipboard \
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

echo "[+] Installing flatpak..."
apt-get install -y \
      flatpak \
      gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "[+] Installing Docker..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  apt-get remove -y $pkg
done
apt-get install -y ca-certificates curl gnupg
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $debian_codename stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
/usr/sbin/groupadd docker 
/usr/sbin/usermod -aG docker $username

echo "[+] Installing Virtualbox..."
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $debian_codename contrib" > /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | \
  gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
apt-get update && apt-get install -y virtualbox-7.0
/usr/sbin/usermod -aG vboxusers $username

echo "[+] Setup done, please reboot."
