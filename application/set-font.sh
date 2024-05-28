sudo apt update && sudo apt upgrade
sudo apt-add-repository contrib non-free -y
sudo apt install software-properties-common -y
sudo apt install ttf-mscorefonts-installer


# Copy the file
sudo cp "fonts.conf" "$HOME/.config/fontconfig/fonts.conf"
# Copy the kde config
sudo cp kdeglobals ~/.config/kdeglobals
# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "File copied successfully."
else
    echo "Failed to copy the file."
fi