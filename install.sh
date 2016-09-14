#!/bin/bash
set -e

# get the user that is not root
# TODO: makes a pretty bad assumption that there is only one other user
USERNAME=$(find /home/* -maxdepth 0 -printf "%f" -type d)
export DEBIAN_FRONTEND=noninteractive

# check if the current user has root privileges
check_is_sudo() {
	if [ "$EUID" -ne 0 ]; then
		echo "Please run as root."
		exit
	fi
}

# check if the current user doesn't have root privileges
check_is_not_sudo() {
	if [ "$EUID" -eq 0 ]; then
		echo "Please do not run as root."
		exit
	fi
}

# setup sudo for a user
setup_sudo() {
  adduser $USERNAME sudo
}

# install virtualbox guest drivers, use when running *inside* a virtual machine
install_virtualbox_guest_drivers() {
  apt-get update
  apt-get install -y \
          build-essential \
          linux-headers-amd64 \
          --no-install-recommends

  echo -e "\n-----------------------------------------------------"
  echo "Please insert the Guest Additions CD image, then run:"
  echo "$ sudo mount /dev/sr0 /media/cdrom"
  echo "$ cd /media/cdrom"
  echo "$ sudo sh ./VBoxLinuxAdditions.run"
  echo "$ sudo reboot now"
  echo -e "-----------------------------------------------------\n"
}

# get dotfiles
get_dotfiles() {
  if [[ -e "$HOME/dotfiles" ]]; then
    cd "$HOME/dotfiles"
    git pull
  else
    cd $HOME
    git clone https://github.com/tbalthazar/dotfiles.git "$HOME/dotfiles"
    cd "$HOME/dotfiles"
  fi
  
  # create a directory to backup dotfiles before copying them
  NOW=$(date +'%Y-%m-%d-%H-%M-%S')
  BACKUP_DIR="$HOME/.dotfiles-backup/$NOW"
  mkdir -p $BACKUP_DIR
  
  # find each file/dir in config-files
  FIND_CMD='find ./config-files -maxdepth 1 ! -name config-files -exec basename {} ;'
  
  for file in $($FIND_CMD)
  do
    # backup existing config files
    FILE_TO_BACKUP="$HOME/$file"
    if [ -e "$FILE_TO_BACKUP" ]; then
      cp -R $FILE_TO_BACKUP $BACKUP_DIR
    fi;
  done;
  
  # copy all the dotfiles to the DEST_DIR
  CP_CMD="cd config-files && find . -type f -exec cp --parents \{\} $HOME \;"
  eval $CP_CMD

  # install/update vim plugins
  vim +PlugUpdate +qall
}

# setup systemd services
setup_services() {
  mkdir -p /etc/systemd/system

  cp "/home/$USERNAME/dotfiles/etc/systemd/system/mpd.service" /etc/systemd/system
  systemctl enable mpd.service
  systemctl start mpd.service

  cp "/home/$USERNAME/dotfiles/etc/systemd/system/i3lock.service" /etc/systemd/system
  systemctl enable i3lock.service
  systemctl start i3lock.service
}

# install base system packages
base() {
  apt-get update
  apt-get -y dist-upgrade
  
  apt-get install -y \
          adduser \
          arandr \
          curl \
          dmenu \
          iceweasel \
          git \
          i3 \
          i3blocks \
          i3lock \
          keepassx \
          lxappearance \
          meld \
          mpd \
          network-manager \
          ncmpcpp \
          openvpn \
          pulseaudio \
          pulseaudio-utils \
          rxvt-unicode-256color \
          sudo \
          tmux \
          transmission \
          tree \
          tzdata \
          vim-nox \
          vlc \
          xautolock \
          xbacklight \
          xclip \
          xorg \
          --no-install-recommends
  
  setup_sudo

  # disable system-wide mpd
  systemctl stop mpd.socket
  systemctl stop mpd
  systemctl disable mpd
}

test() {
  # echo "Username: $USERNAME"
  # echo "Home: $HOME"
  check_is_not_sudo
  if [[ -e "$HOME/dotfiles" ]]; then
    echo "$HOME/dotfiles exists"
  else
    echo "$HOME/dotfiles do not exist"
  fi
}

usage() {
	echo -e "install.sh\n\tThis script installs my basic setup for a Debian laptop.\n"
	echo "Usage:"
	echo "  base                     - install base pkgs"
	echo "  virtualbox               - install virtualbox guest drivers, use when running *inside* a virtual machine"
	echo "  dotfiles                 - get dotfiles"
	echo "  services                 - install and configure services"
}

main() {
  local cmd=$1
  
  if [[ -z "$cmd" ]]; then
    usage
    exit 1
  fi
  
  if [[ $cmd == "base" ]]; then
    check_is_sudo
    base
  elif [[ $cmd == "virtualbox" ]]; then
    check_is_sudo
    install_virtualbox_guest_drivers
  elif [[ $cmd == "dotfiles" ]]; then
    check_is_not_sudo
    get_dotfiles
  elif [[ $cmd == "services" ]]; then
    check_is_sudo
    setup_services
  elif [[ $cmd == "test" ]]; then
    test
  else
    usage
  fi
}

main "$@"
