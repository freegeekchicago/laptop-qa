#Detect terminal on the system, then execute menu script in that terminal:
hash xfce4-terminal 2> /dev/null && xfce4-terminal -e "./data/qa-menu.sh" 2> /dev/null || (hash gnome-terminal 2> /dev/null && gnome-terminal -e "./data/qa-menu.sh" 2> /dev/null || xterm -e "./data/qa-menu.sh" 2> /dev/null ) 
