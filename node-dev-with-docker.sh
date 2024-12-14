#!/bin/bash

# Add user to sudoers
echo "Adding user to sudoers..."
su -c "usermod -aG sudo $USER" root
su -c "echo '$USER ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/$USER" root

# Update system
echo "Updating system..."
sudo apt-get update && sudo apt-get upgrade -y

# Install dependencies
echo "Installing base packages..."
sudo apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release

# Install fnm
echo "Installing fnm..."
curl -fsSL https://fnm.vercel.app/install | bash
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.bashrc

# Install Docker
echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Setup Docker permissions
echo "Setting up Docker permissions..."
sudo groupadd docker || true
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker

# Install Docker Compose
echo "Installing Docker Compose..."
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
sudo curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Node.js LTS
echo "Installing Node.js LTS..."
source ~/.bashrc
fnm install --lts
fnm default lts-latest

echo "Installation complete! Please log out and back in for group changes to take effect."
echo "Then verify installations with:"
echo "- docker --version"
echo "- docker compose version"
echo "- node --version"


#!/bin/bash

# Install Google Chrome
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Install Discord
echo "Installing Discord..."
wget "https://discord.com/api/download?platform=linux&format=deb" -O discord.deb
sudo apt install -y ./discord.deb
rm discord.deb

# Install Telegram
echo "Installing Telegram..."
sudo apt install -y telegram-desktop

# Install MongoDB Compass
echo "Installing MongoDB Compass..."
wget https://downloads.mongodb.com/compass/mongodb-compass_1.45.0_amd64.deb
sudo apt install -y ./mongodb-compass_1.40.4_amd64.deb
rm mongodb-compass_1.40.4_amd64.deb

# Install Docker Desktop
echo "Installing Docker Desktop..."
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.27.2-amd64.deb
sudo apt install -y ./docker-desktop-4.27.2-amd64.deb
rm docker-desktop-4.27.2-amd64.deb

# Start Docker Desktop service
systemctl --user enable docker-desktop
systemctl --user start docker-desktop

echo "Installation complete! You can now launch the applications from your system menu."
