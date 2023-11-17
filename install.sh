#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Add source list



# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Install Nix
sh <(curl -L https://nixos.org/nix/install) --no-daemon

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/.config
mkdir -p /home/$username/.fonts
mkdir -p /home/$username/Pictures
mkdir -p /home/$username/Pictures/backgrounds
cp -R dotfiles/* /home/$username/
cp bg.jpg /home/$username/Pictures/backgrounds/
chown -R $username:$username /home/$username

# Installing Essential Programs 
nala install kitty unzip wget build-essential libgtk-4-1 libgtk-3-0 -y

# Pipewire Pulse
nala install wireplumber pipewire-media-session pipewire-pulse pipewire-alsa pipewire-audio-client-libraries libspa-0.2-jack -y
systemctl --user -M $username@ --now enable wireplumber.service
touch /etc/pipewire/media-session.d/with-jack
cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
ldconfig

# Installing Other less important Programs
nala install neofetch flameshot psmisc vim -y

# Dev utils
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz

curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh


# Installing fonts
cd $builddir 
nala install fonts-font-awesome -y

# Fira
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts

# Melso
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip
unzip Meslo.zip -d /home/$username/.fonts

# Jetbrains
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip


chown $username:$username /home/$username/.fonts/*

# Reloading Font
fc-cache -vf

# Setup .zsh
sudo nala install zsh

# Use nala
bash scripts/usenala 

# Install Zen kernel
curl -s 'https://liquorix.net/install-liquorix.sh' | sudo bash

# Removing zip Files
rm -rf *.zip

# Reboot
reboot