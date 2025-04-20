#!/bin/bash

# Color helpers
GREEN='\033[1;32m'
NC='\033[0m' # No Color

# Check if the user is root or using sudo
if [[ $EUID -ne 0 ]]; then
  echo -e "${GREEN}[*] Using sudo for package operations...${NC}"
  SUDO="sudo"
else
  SUDO=""
fi

# Command dispatcher
case "$1" in
  install|i)
    shift
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Installing: $@${NC}"
    $SUDO apt install "$@"
    ;;
  upgrade|u)
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Upgrading packages...${NC}"
    $SUDO apt upgrade
    echo -e "${GREEN}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove --purge -y
    ;;
  remove|rm)
    shift
    echo -e "${GREEN}[-] Removing: $@${NC}"
    $SUDO apt remove "$@"
    echo -e "${GREEN}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove -y
    ;;
  purge|p)
    shift
    echo -e "${GREEN}[x] Purging: $@${NC}"
    $SUDO apt purge "$@"
    echo -e "${GREEN}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove --purge -y
    ;;
  *)
    echo "Usage:"
    echo "  zap install <pkg>"
    echo "  zap upgrade"
    echo "  zap remove <pkg>"
    echo "  zap purge <pkg>"
    exit 1
    ;;
esac
