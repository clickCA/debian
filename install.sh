#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

if [ $# -eq 0 ]; then
  echo "Please input amd/nv for GPU drivers."
  echo "If you do not wish to install these drivers, please input no-gpu"
  exit 1
fi

username=$(logname)
builddir=$(pwd)

# Add source list
if [ -e sources.list ]; then
  cp "sources.list" "/etc/apt/"
fi

if [ -d sources.list.d ]; then
  cp -r "sources.list.d" "/etc/apt/"
fi

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Making .config and Moving config files and background to Pictures
cd "$builddir" || exit
mkdir -p "/home/$username/.config"
mkdir -p "/home/$username/.fonts"
mkdir -p "/home/$username/Pictures/backgrounds"
mkdir -p "/home/$username/Application"
cp -R dotfiles/* "/home/$username/"
cp "bg.png" "/home/$username/Pictures/backgrounds/"
chown -R "$username:$username" "/home/$username"

# Installing Essential Programs 
nala install kitty unzip wget build-essential libgtk-4-1 libgtk-3-0 -y

# Pipewire Pulse
nala install wireplumber pipewire-media-session pipewire-pulse pipewire-alsa pipewire-audio-client-libraries libspa-0.2-jack -y
systemctl --user -M "$username@" --now enable wireplumber.service
touch "/etc/pipewire/media-session.d/with-jack"
cp "/usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf" "/etc/ld.so.conf.d/"
ldconfig

# Installing Other less important Programs
nala install neofetch flameshot psmisc vim -y

# Dev utils
wget "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
tar xzvf "nvim-linux64.tar.gz" -C "/home/$username/Application"
ln -s "/home/$username/Application/nvim-linux64/bin/nvim" "/usr/bin"

curl -sLk "https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh" | sh

# Installing fonts
cd "$builddir" || exit
nala install fonts-font-awesome -y

# Fira
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip"
unzip "FiraCode.zip" -d "/home/$username/.fonts"

# Meslo
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip"
unzip "Meslo.zip" -d "/home/$username/.fonts"

# JetBrainsMono
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
unzip "JetBrainsMono.zip" -d "/home/$username/.fonts"

chown "$username:$username" "/home/$username/.fonts/*"

# Reloading Font
fc-cache -vf

# Setup .zsh
nala install zsh

# install fcitx5
nala install --install-recommends fcitx5 fcitx5-mozc
nala remove uim uim-mozc
nala install kde-config-fcitx5

# Amd drivers
if [ "$1" == "amd" ]; then
  nala install firmware-amd-graphics libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all
fi

# Install Zen kernel
curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

# Removing zip Files
rm -rf *.zip

# Reboot
echo "Installation completed. Reboot your system for changes to take effect."
