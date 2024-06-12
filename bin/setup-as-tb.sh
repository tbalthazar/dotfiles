#!/usr/bin/env bash

if [ "$EUID" -eq 0 ]
  then echo "Don't run this script as root."
  exit
fi

bindl=~/.bin-dl
obsidian_version='1.6.3'
asdf_version='v0.14.0'
rclone_version='1.65.2'

flatpak_apps=(
  com.discordapp.Discord
  com.google.Chrome
  com.slack.Slack
  com.spotify.Client
  com.transmissionbt.Transmission
  net.ankiweb.Anki
  org.videolan.VLC
)

echo "[+] Installing some apps via Flatpak..."
for app in "${flatpak_apps[@]}"; do
  echo "  [+] Installing $app with Flatpak..."
  flatpak install -y flathub "$app"
done

echo "[+] Installing neovim..."
mkdir -p $bindl
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -O $bindl/nvim.appimage
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage.sha256sum -O $bindl/nvim.appimage.sha256sum
cd $bindl
sha256sum -c nvim.appimage.sha256sum
rm $bindl/nvim.appimage.sha256sum
chmod +x nvim.appimage
ln -s nvim.appimage nvim
ln -s nvim.appimage vim
ln -s nvim.appimage vi
cd ~

echo "[+] Installing Obsidian..."
mkdir -p $bindl
wget https://github.com/obsidianmd/obsidian-releases/releases/download/v$obsidian_version/Obsidian-$obsidian_version.AppImage \
  -O $bindl/obsidian.appimage
cd $bindl
chmod +x obsidian.appimage
./obsidian.appimage --appimage-extract
cd squashfs-root
# replace Exec=AppRun --no-sandbox %U by the full path of the downloaded appimage
sed -i 's/^Exec=.*/Exec=\/home\/tb\/.bin-dl\/obsidian.appimage --no-sandbox %U/' obsidian.desktop
mkdir -p ~/.local/share/applications
mkdir -p ~/.local/share/icons/hicolor/512x512/apps
cp obsidian.desktop ~/.local/share/applications
cp obsidian.png ~/.local/share/icons/hicolor/512x512/apps
update-desktop-database ~/.local/share/applications -v
rm -rf ./squashfs-root
cd ~

echo "[+] Installing rclone..."
mkdir -p $bindl
rclone_tmp_dir=$(mktemp -d)
wget \
  https://github.com/rclone/rclone/releases/download/v$rclone_version/rclone-v$rclone_version-linux-amd64.zip \
  -O $rclone_tmp_dir/rclone-v$rclone_version-linux-amd64.zip
cd $rclone_tmp_dir
unzip rclone-v$rclone_version-linux-amd64.zip
cp rclone-v$rclone_version-linux-amd64/rclone $bindl/
chmod +x $bindl/rclone
rm -rf $rclone_tmp_dir
cd ~

echo "[+] Installing dotfiles..."
git clone https://github.com/tbalthazar/dotfiles ~/.dotfiles
rcup -v -f -d ~/.dotfiles/dotfiles -t linux-desktop

echo "[+] Installing asdf..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $asdf_version
. "$HOME/.asdf/asdf.sh"
for plugin in golang ruby kubectl terraform packer; do
  echo "[+] Installing $plugin with asdf..."
  asdf plugin add $plugin
  asdf install $plugin latest
  asdf global $plugin latest
done

echo "[+] Installing fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --completion --key-bindings --no-update-rc

echo "[+] Done."
