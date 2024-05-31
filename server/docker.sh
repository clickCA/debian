# Official document installation

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update


sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add Docker compose plugin
sudo apt-get install docker-compose-plugin
docker compose version


#To create the docker group and add your user:

#Create the docker group.

sudo groupadd docker
#Add your user to the docker group.
sudo usermod -aG docker $USER
#Log out and log back in so that your group membership is re-evaluated.

#If you're running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

#You can also run the following command to activate the changes to groups:
newgrp docker