#!/bin/bash
# To turn off monitor in console, the command is the following: https://askubuntu.com/questions/62858/turn-off-monitor-using-command-line


# Check if vbetool is installed
if ! command -v vbetool &> /dev/null; then
  echo "vbetool not found. Installing..."
  sudo apt-get update  # Update package lists (optional, but recommended)
  sudo apt-get install vbetool
else
  echo "vbetool already installed."
fi

sudo vbetool dpms off
# To regain control of the console on pressing Enter key, I suggest

sudo sh -c 'vbetool dpms off; read ans; vbetool dpms on'
