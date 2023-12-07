#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(logname)
builddir=$(pwd)

echo "# Debian Sid" | tee -a /etc/apt/sources.list
echo "deb http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware" | tee -a /etc/apt/sources.list

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
cp bg* "/home/$username/Pictures/backgrounds/"
chown -R "$username:$username" "/home/$username"

# Installing Essential Programs 
nala install kitty unzip wget curl build-essential libgtk-4-1 libgtk-3-0 qemu -y

# Installing Other less important Programs
nala install neofetch flameshot psmisc vim -y

# Pipewire
nala install wireplumber pipewire-media-session- -y
systemctl --user --now enable wireplumber.service
nala install pipewire-pulse pipewire-alsa pipewire-audio-client-libraries libspa-0.2-jack libspa-0.2-bluetooth -y

# =================================== Dev Utils ===================================

# NVIM
wget "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz"
tar xzvf "nvim-linux64.tar.gz" -C "/home/$username/Application"
ln -s "/home/$username/Application/nvim-linux64/bin/nvim" "/usr/bin"

# GOBREW
curl -sLk "https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh" | sh

# PYENV
curl https://pyenv.run | bash

# NODE
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# VSCODE
nala install code -y

# DOCKER
# Add Docker's official GPG key:
nala install ca-certificates curl gnupg -y
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Github CLI
nala install gh -y

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  bookworm stable" | \
   tee /etc/apt/sources.list.d/docker.list > /dev/null
nala update
nala install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
usermod -aG docker $USER
newgrp docker

# =================================================================================

# Installing fonts
# === FOSS ===

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

# === NON-FREE ===

chown "$username:$username" "/home/$username/.fonts/*"

# Reloading Font
fc-cache -vf

# Setup .zsh
nala install zsh -y

# install fcitx5
nala install --install-recommends fcitx5 fcitx5-mozc -y
nala install kde-config-fcitx5 -y

# Removing zip Files
rm -rf *.zip
rm -rf *.tar.gz

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
