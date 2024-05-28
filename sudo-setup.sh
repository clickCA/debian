#!/bin/bash
su -
user='click'

# Remove cdrom entry from sources.list
sed -i '/cdrom/d' /etc/apt/sources.list

# Verify the content of sources.list
grep -v '#' /etc/apt/sources.list

# Install sudo
apt-get update
apt-get install -y sudo

# Add user to sudo group
usermod -aG sudo $user

# Verify sudo installation
sudo -v
if [ $? -eq 0 ]; then
    echo "sudo setup completed successfully"
else
    echo "sudo setup failed"
fi

# Grant sudo access to the user
echo "$user ALL=(ALL) ALL" | tee -a /etc/sudoers