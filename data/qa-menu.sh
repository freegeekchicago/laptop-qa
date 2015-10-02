#!/bin/bash
# qa-menu.sh: Menu for QA scripts

_run() {
  echo -e "\rPlease wait..."
  [ ! -f "$1" ] && wget -O "$1"
  clear
  bash "./$1"
  echo -en "\nPress any key to return to the menu..."
  read -n1 input
  _menu
}

_menu() {
clear
cat <<tac
|             QA Menu              |
| Press one of the following keys: |
|__________________________________|

  i : Install iSight camera firmware
  k : Keyboard Test
  K : Full Keyboard Test
  s : System Information
  w : Install Broadcom wireless firmware
 Esc: Exit

tac
read -n1 input
case "$input" in
  i) _run isight.sh;;
  k) _run keyboard-test.sh;;
  K) _run full-keyboard-test.sh;;
  s) _run system-information.sh;;
  w) _run broadcom.sh;;
  *) loop=0;;
esac
}

cd $(dirname $0)
_menu
