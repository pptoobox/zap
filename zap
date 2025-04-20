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
    if [[ $# -eq 0 ]]; then
      echo -e "${GREEN}[!] No packages specified to install.${NC}"
      exit 1
    fi
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Installing: $@${NC}"
    $SUDO apt install "$@"
    ;;
  upgrade|u)
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Upgrading packages...${NC}"
    $SUDO apt full-upgrade
    echo -e "${GREEN}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove --purge -y
    ;;
  remove|rm)
    shift
    if [[ $# -eq 0 ]]; then
      echo -e "${GREEN}[!] No packages specified to remove.${NC}"
      exit 1
    fi
    echo -e "${GREEN}[-] Removing: $@${NC}"
    $SUDO apt remove "$@"
    echo -e "${GREEN}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove -y
    ;;
  purge|p)
    shift
    if [[ $# -eq 0 ]]; then
      echo -e "${GREEN}[!] No packages specified to purge.${NC}"
      exit 1
    fi
    echo -e "${GREEN}[x] Purging: $@${NC}"
    $SUDO apt purge "$@"
    echo -e "${GREEN}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove --purge -y
    ;;
  help|h)
    echo -e "${GREEN}Usage:${NC}"
    echo "  zap install <pkg>   Install packages"
    echo "  zap upgrade         Upgrade all packages"
    echo "  zap remove <pkg>    Remove packages"
    echo "  zap purge <pkg>     Purge packages"
    echo "  zap help            Show this message"
    ;;
  *)
    echo -e "${GREEN}[!] Unknown command.${NC}"
    echo "Try 'zap help' for usage."
    exit 1
    ;;
esac