#!/bin/bash

# Source and destination paths
source_path="$HOME/.config/fontconfig/fonts.conf"
destination_path="fonts.conf"

# Copy the file
cp "$source_path" "$destination_path"

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "File copied successfully."
else
    echo "Failed to copy the file."
fi