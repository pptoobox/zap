#!/bin/bash

# Color helpers
BC='\033[1;32m'
NC='\033[0m'

# Check if the user is root or using sudo
if [[ $EUID -ne 0 ]]; then
  echo -e "${BC}[*] Using sudo for package operations...${NC}"
  SUDO="sudo"
else
  SUDO=""
fi

# Define repeating constants
checkinput () {
  shift
  if [[ $# -eq 0 ]]; then
    echo -e "${BC}[!] No package specified.${NC}"
    exit 1
  fi
}
updaterepo () {
  echo -e "${BC}[+] Updating package lists...${NC}"
  $SUDO apt update
}

# Command dispatcher
case "$1" in
  list|l)
    updaterepo
    echo -e "${BC}[+] Listing all packages:${NC}"
    $SUDO apt list
    ;;
  list-installed|li)
    echo -e "${BC}[+] Listing installed packages:${NC}"
    $SUDO apt list -i
    ;;
  list-upgradable|lu)
    updaterepo
    echo -e "${BC}[+] Listing upgradable packages:${NC}"
    $SUDO apt list -u
    ;;
  search|s)
    checkinput
    updaterepo
    echo -e "${BC}[+] Searching for: $@${NC}"
    $SUDO apt search "$@"
    ;;
  show-info|si)
    checkinput
    $SUDO apt show "$@"
    ;;
  update|u)
    updaterepo
    ;;
  install|i)
    checkinput
    updaterepo
    echo -e "${BC}[+] Installing: $@${NC}"
    $SUDO apt install "$@"
    ;;
  reinstall|ri)
    checkinput
    updaterepo
    echo -e "${BC}[+] Re-installing: $@${NC}"
    $SUDO apt reinstall "$@"
    ;;
  full-upgrade|fu)
    updaterepo
    echo -e "${BC}[+] Upgrading packages...${NC}"
    $SUDO apt full-upgrade
    echo -e "${BC}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove --purge -y
    ;;
  remove|rm)
    checkinput
    echo -e "${BC}[-] Removing: $@${NC}"
    $SUDO apt remove "$@"
    echo -e "${BC}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove -y
    ;;
  purge|p)
    checkinput
    echo -e "${BC}[x] Purging: $@${NC}"
    $SUDO apt purge "$@"
    echo -e "${BC}[✓] Clearing unused packages...${NC}"
    $SUDO apt autoremove --purge -y
    ;;
  self-update|su)
    echo -e "${BC}[-] Removing old script...${NC}"
    $SUDO rm /usr/local/bin/zap
    echo -e "${BC}[+] Downloading zap script from GitHub...${NC}"
    $SUDO curl -s -o /usr/local/bin/zap https://raw.githubusercontent.com/pptoolbox/zap/main/zap
    echo -e "${BC}[+] Making zap executable...${NC}"
    $SUDO chmod +x /usr/local/bin/zap
    echo -e "${BC}\n[✓] Update complete.${NC}"
    ;;
  self-destruct|sd)
    echo -e "${BC}[-] Completely removing zap from your system...${NC}"
    $SUDO rm /bin/zap
    $SUDO rm /usr/local/bin/zap
    echo -e "${BC}\n[✓] Good bye.${NC}"
    ;;
  help|h)
    echo -e "${BC}Usage:${NC}"
    echo "  zap <command>"
    echo -e "${BC}Commands:${NC}"
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
    echo -e "${BC}[!] Unknown command.${NC}"
    echo "Try 'zap help or zap h' for usage."
    exit 1
    ;;
esac
