hash xfce4-terminal && xfce4-terminal -e "./data/qa-menu.sh" || (hash gnome-terminal && gnome-terminal -e "./data/qa-menu.sh" || xterm -e "./data/qa-menu.sh")
