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
  list|l)
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Listing all packages:${NC}"
    $SUDO apt list
    ;;
  list-installed|li)
    echo -e "${GREEN}[+] Listing installed packages:${NC}"
    $SUDO apt list -i
    ;;
  list-upgradable|lu)
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Listing upgradable packages:${NC}"
    $SUDO apt list -u
    ;;
  search|s)
    shift
    if [[ $# -eq 0 ]]; then
      echo -e "${GREEN}[!] No package specified to search.${NC}"
      exit 1
    fi
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Searching for: $@${NC}"
    $SUDO apt search "$@"
    ;;
  show-info|si)
    shift
    if [[ $# -eq 0 ]]; then
      echo -e "${GREEN}[!] No package specified to show info.${NC}"
      exit 1
    fi
    $SUDO apt show "$@"
    ;;
  update|u)
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    ;;
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
  reinstall|ri)
    shift
    if [[ $# -eq 0 ]]; then
      echo -e "${GREEN}[!] No packages specified to re-install.${NC}"
      exit 1
    fi
    echo -e "${GREEN}[+] Updating package lists...${NC}"
    $SUDO apt update
    echo -e "${GREEN}[+] Re-installing: $@${NC}"
    $SUDO apt reinstall "$@"
    ;;
  full-upgrade|fu)
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
  self-update|su)
    echo -e "${GREEN}[-] Removing old script...${NC}"
    $SUDO rm /usr/local/bin/zap
    echo -e "${GREEN}[+] Downloading zap script from GitHub...${NC}"
    $SUDO curl -s -o /usr/local/bin/zap https://raw.githubusercontent.com/pptoolbox/zap/main/zap
    echo -e "${GREEN}[+] Making zap executable...${NC}"
    $SUDO chmod +x /usr/local/bin/zap
    echo -e "${GREEN}\n[✓] Update complete.${NC}"
    ;;
  self-destruct|sd)
    echo -e "${GREEN}[-] Completely removing zap from your system...${NC}"
    $SUDO rm /bin/zap
    $SUDO rm /usr/local/bin/zap
    echo -e "${GREEN}\n[✓] Good bye.${NC}"
    ;;
  help|h)
    echo -e "${GREEN}Usage:${NC}"
    echo "  zap <command>"
    echo -e "${GREEN}Commands:${NC}"
    echo "  list             , l           > List packages"
    echo "  list-installed   , li          > List installed packages"
    echo "  list-upgradable  , lu          > List upgradable packages"
    echo "  search <pkg>     , s <pkg>     > Search for any package"
    echo "  show-info <pkg>  , si <pkg>    > Show info about any packages"
    echo "  update           , u           > Update package lists"
    echo "  install <pkg>    , i <pkg>     > Install packages"
    echo "  reinstall <pkg>  , ri <pkg>    > Re-install packages"
    echo "  full-upgrade     , fu          > Fully upgrade all packages"
    echo "  remove <pkg>     , rm <pkg>    > Remove packages"
    echo "  purge <pkg>      , p <pkg>     > Purge packages"
    echo "  self-update      , su          > Update/Reinstall zap"
    echo "  self-destruct    , sd          > Completely remove zap"
    ;;
  *)
    echo -e "${GREEN}[!] Unknown command.${NC}"
    echo "Try 'zap help or zap h' for usage."
    exit 1
    ;;
esac