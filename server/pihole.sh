sudo apt install ufw
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
ufw allow 80/tcp
ufw allow 53/tcp
ufw allow 53/udp
ufw allow 67/tcp
ufw allow 67/udp
sudo apt install curl
sudo apt install git
sudo apt install python3
curl -sSL https://install.pi-hole.net | bash