hash xfce4-terminal && xfce4-terminal -e "./data/qa-menu.sh" || (hash gnome-terminal && gnome-terminal -e "./data/qa-menu.sh" || xterm -e "./data/qa-menu.sh")
#if [ "$?" == 0 ]; then
#  xfce4-terminal -e "./data/qa-menu.sh"
#else
#  which gnome-terminal > /dev/null
#  if [ "$?" == 0 ]; then
#    gnome-terminal -e "./data/qa-menu.sh"
#  else
#    xterm -e "./data/qa-menu.sh"
#  fi
#fi
