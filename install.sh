#!/bin/bash

# Variables
ZAP_REPO="https://raw.githubusercontent.com/pptoolbox/zap/main/zap"
DEST="/usr/local/bin/zap"
SYMLINK="/bin/zap"

# Ensure we're running as root or using sudo
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root or with sudo."
  exit 1
fi

# Download the zap script from GitHub
echo "Downloading zap script from GitHub..."
curl -s -o $DEST $ZAP_REPO

# Make it executable
echo "Making zap executable..."
chmod +x $DEST

# Create symlink in /bin
echo "Creating symlink in /bin..."
ln -s $DEST $SYMLINK

# Confirm installation
echo -e "\nInstallation complete! You can now use the 'zap' command from anywhere."
