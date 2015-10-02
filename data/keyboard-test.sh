#!/bin/bash
ver=0.2.3
mode="laptop"
keys="'Escape' 'F1' 'F2' 'F3' 'F4' 'F5' 'F6' 'F7' 'F8' 'F9' 'F10' 'F11' 'F12'\n\
      'grave' '1' '2' '3' '4' '5' '6' '7' '8' '9' '0' 'minus' 'equal' 'BackSpace'\n\
      'Tab' 'q' 'w' 'e' 'r' 't' 'y' 'u' 'i' 'o' 'p' 'bracketleft' 'bracketright' 'backslash'\n\
      'Caps_Lock' 'a' 's' 'd' 'f' 'g' 'h' 'j' 'k' 'l' 'semicolon' 'apostrophe' 'Return'\n\
      'Shift_L' 'z' 'x' 'c' 'v' 'b' 'n' 'm' 'comma' 'period' 'slash' 'Shift_R'\n\
      'Control_L' 'Super_L' 'Alt_L' 'space' 'Alt_R' 'Menu' 'Control_R'\n\
      'Scroll_Lock' 'Pause' 'Insert' 'Home' 'Prior' 'Delete' 'End' 'Next'\n\
      'Left' 'Right' 'Up' 'Down' 'Num_Lock'"
if [[ ${mode} == "full" ]]; then
   keys="${keys} 'Super_R' 'Print' 'KP_Divide' 'KP_Multiply' 'KP_Subtract' 'KP_Add' 'KP_Enter'\n\
         'KP_0' 'KP_1' 'KP_2' 'KP_3' 'KP_4' 'KP_5' 'KP_6' 'KP_7' 'KP_8' 'KP_9' 'KP_Decimal'"
fi
function countKeys() {
   echo $(($(echo ${keys} | grep -o "'" | wc -l)/2))
}
FULLSIZE=$(countKeys)
COLUMNS=$(tput cols)
if [[ "$1" == "--display-events" ]]; then
   xev | awk -Winteractive '/keysym 0x.*, .*\)/{print substr($7,0,length($7)-1)}'
else
   echo -n "Focus the \"Event Tester\" window and press any key to begin..."
   xev | awk -Winteractive '/keysym 0x.*, .*\)/{print substr($7,0,length($7)-1)}' | \
   while read key; do
      clear
      tput cup 0 0
      echo "KBTest $ver (Ctrl-C to exit)"
      keys=$(echo ${keys} | sed -e "s/'${key}'\( \)*//")
      if [[ $(countKeys) == 0 ]]; then
         echo -e "\033[32mTest OK\033[0m"
         break
      else
         printf "\033[31m"
         echo -e ${keys} | sed -e "s/'//g"
         printf "\033[0m"
      fi
      for ((i=0;i<$COLUMNS;i++)); do
         echo -n '-'
      done
      echo
      spaces=''
      for ((i=0;i<(13-${#key});i++)); do
         spaces="$spaces "
      done
      size=$(countKeys)
      echo -en "[\033[32m$key\033[0m]${spaces}($size remain / $(((${FULLSIZE}-${size})*100/${FULLSIZE}))% complete)\t"
   done
fi
