#!/bin/bash
# broadcom.sh: install broadcom firmware

printf "\e[38;5;255;45m Detecting wireless card...                                                    \n\e[m"

_b43() {
  printf "\e[38;5;255;42m Detected standard BCM43xx. Installing...                                      \n\e[m"
  sudo apt-get -y install b43-fwcutter firmware-b43-installer
  _status
}

_legacy() {
  printf "\e[38;5;255;42m Detected legacy BCM43xx. Installing...                                        \n\e[m"
  sudo apt-get -y install b43-fwcutter firmware-b43legacy-installer
  _status
}

_lp-phy() {
  printf "\e[38;5;255;42m Detected BCM4312 (LP-PHY). Installing...                                      \n\e[m"
  sudo apt-get -y install b43-fwcutter firmware-b43-lpphy-installer
  _status
}

_other() {
  printf "\e[38;5;255;101m ERROR: Couldn't detect specific Broadcom chipset.                             \n\e[m"
}

_status() {
  case "$?" in
    0) printf "\e[38;5;255;42m Done.                                                                         \n\e[m";;
    *) printf "\e[38;5;255;101m Failed.                                                                       \n\e[m";;
  esac
}

PCI="$(lspci | grep -i 'broadcom.*802\.11')"
case "$PCI" in
  *"BCM4312"*) _lp-phy;;
  *"BCM4301"*) _legacy;;
  *"BCM43"*  ) _b43   ;;
  *          ) _other ;;
esac
