#!/bin/bash
# system-information.sh: System Information Tool

# OPTIONS
highlight="32"  # Highlight color

# FUNCTION DEFINITION
hddRound() {
  if   [ $1 -le 8    ]; then
    echo "$1 GB"
  elif [ $1 -le 10   ]; then
    echo "10 GB"
  elif [ $1 -le 12   ]; then
    echo "12 GB"
  elif [ $1 -le 20   ]; then
    echo "20 GB"
  elif [ $1 -le 30   ]; then
    echo "30 GB"
  elif [ $1 -le 40   ]; then
    echo "40 GB"
  elif [ $1 -le 60   ]; then
    echo "60 GB"
  elif [ $1 -le 80   ]; then
    echo "80 GB"
  elif [ $1 -le 100  ]; then
    echo "100 GB"
  elif [ $1 -le 120  ]; then
    echo "120 GB"
  elif [ $1 -le 160  ]; then
    echo "160 GB"
  elif [ $1 -le 180  ]; then
    echo "180 GB"
  elif [ $1 -le 200  ]; then
    echo "200 GB"
  elif [ $1 -le 250 ]; then
    echo "250 GB"
  elif [ $1 -le 300  ]; then
    echo "300 GB"
  elif [ $1 -le 320  ]; then
    echo "320 GB"
  elif [ $1 -le 400  ]; then
    echo "400 GB"
  elif [ $1 -le 450  ]; then
    echo "450 GB"
  elif [ $1 -le 500  ]; then
    echo "500 GB"
  elif [ $1 -le 640  ]; then
    echo "640 GB"
  elif [ $1 -le 750  ]; then
    echo "750 GB"
  elif [ $1 -le 1000 ]; then
    echo "1.0 TB"
  elif [ $1 -le 1500 ]; then
    echo "1.5 TB"
  elif [ $1 -le 2000 ]; then
    echo "2.0 TB"
  elif [ $1 -le 2500 ]; then
    echo "2.5 TB"
  elif [ $1 -le 3000 ]; then
    echo "3.0 TB"
  elif [ $1 -le 4000 ]; then
    echo "4.0 TB"
  else
    echo "$1 GB"
  fi
}
memRound() {
  if   [ $1 -le 128  ]; then
    echo "$1 MB"
  elif [ $1 -le 192  ]; then
    echo "192 MB"
  elif [ $1 -le 256  ]; then
    echo "256 MB"
  elif [ $1 -le 384  ]; then
    echo "384 MB"
  elif [ $1 -le 512  ]; then
    echo "512 MB"
  elif [ $1 -le 768  ]; then
    echo "768 MB"
  elif [ $1 -le 1024 ]; then
    echo "1.0 GB"
  elif [ $1 -le 1280 ]; then
    echo "1.25 GB"
  elif [ $1 -le 1536 ]; then
    echo "1.5 GB"
  elif [ $1 -le 2048 ]; then
    echo "2.0 GB"
  elif [ $1 -le 2304 ]; then
    echo "2.25 GB"
  elif [ $1 -le 2560 ]; then
    echo "2.5 GB"
  elif [ $1 -le 3072 ]; then
    echo "3.0 GB"
  elif [ $1 -le 3328 ]; then
    echo "3.25 GB"
  elif [ $1 -le 3584 ]; then
    echo "3.5 GB"
  elif [ $1 -le 4096 ]; then
    echo "4.0 GB"
  elif [ $1 -le 4352 ]; then
    echo "4.25 GB"
  elif [ $1 -le 4608 ]; then
    echo "4.5 GB"
  elif [ $1 -le 5120 ]; then
    echo "5.0 GB"
  elif [ $1 -le 5376 ]; then
    echo "5.25 GB"
  elif [ $1 -le 5632 ]; then
    echo "5.5 GB"
  elif [ $1 -le 6144 ]; then
    echo "6.0 GB"
  elif [ $1 -le 6400 ]; then
    echo "6.25 GB"
  elif [ $1 -le 6656 ]; then
    echo "6.5 GB"
  elif [ $1 -le 7168 ]; then
    echo "7.0 GB"
  elif [ $1 -le 7424 ]; then
    echo "7.25 GB"
  elif [ $1 -le 7680 ]; then
    echo "7.5 GB"
  elif [ $1 -le 8192 ]; then
    echo "8.0 GB"
  else
    echo "$1 MB"
  fi
}
specProcess() {
   if   [[ ${1} == 'init' ]]; then
      specString=''
   elif [[ ${1} == 'add' && ${2} != '' ]]; then
      if [[ ${specString} == '' ]]; then
         specString=${2}
      else
         specString="${specString} + ${2}"
      fi
   elif [[ ${1} == 'return' ]]; then
      echo ${specString}
   fi
}

# DATA ACQUISITION
sudo true || exit 1
dmidecode=$(sudo dmidecode)
mfgr=$(echo "$dmidecode" | grep "System Information" -A1 | tail -n1 | grep "Manufacturer:" | head -n1 | cut -d: -f2 | cut -c2- | cut -d' ' -f1)' '
if [[ ${mfgr,,} == "lenovo " ]]; then
  mfgr="Lenovo "
  model=$(echo "$dmidecode" | grep "Family:" | head -n1 | cut -d: -f2 | cut -c2- | sed "s/$mfgr//")
else
  model=$(echo "$dmidecode" | grep "Product Name:" | head -n1 | cut -d: -f2 | cut -c2- | sed "s/$mfgr//")
fi
if   [ -n "$(which lsb_release)" ]; then
  lsbRelease=$(lsb_release -d | cut -d: -f2 | sed 's/\t//')
elif [ -n "$(which uname)" ]; then
  lsbRelease=$(uname -o)
else
  lsbRelease="Unknown"
fi
arch=$(uname -m)
cpuinfo=$(cat /proc/cpuinfo | grep "model name" | sort -u | cut -c14- | sed 's/  //g;s/@/ @/;s/Genuine //;s/ processor//;s/(R)//g;s/(tm)//g;s/(TM)//g;s/ Technology//')
if [ -f /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq ]; then
   cpufreq=$(bc <<< "scale=2;"$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)"/1000000")" GHz"
else
   cpufreq=$(cat /proc/cpuinfo | grep -i mhz | head -n1 | cut -d: -f2 | cut -c2- | cut -d. -f1)" MHz"
fi
mem=$(memRound $(($(grep MemTotal /proc/meminfo | awk '{print $2}')/1024)))
hdd=$(df -B1000 | grep '/dev/sda' | awk '{print $2}')
if [ -z ${hdd} ]; then
  hdd=$(df -B1000 | grep '/dev/disk' | awk '{print $2}')
fi
[ -z "$hdd" ] && hdd="None" || hdd=$(hddRound $((${hdd}/1000000)))
cdromInfo=$(cat /proc/sys/dev/cdrom/info)
dvdWrite=$(echo "$cdromInfo" | grep "Can write DVD-R:" | awk '{print $4}')
dvdRead=$(echo "$cdromInfo" | grep "Can read DVD:" | awk '{print $4}')
cdWrite=$(echo "$cdromInfo" | grep "Can write CD-R:" | awk '{print $4}')
cdRead=$(echo "$cdromInfo" | grep "Can play audio:" | awk '{print $4}')
specProcess init
if   [[ $dvdWrite == "1" ]]; then
   specProcess add "DVD Burner"
elif [[ $dvdRead == "1" ]]; then
   specProcess add "DVD Player"
fi
if   [[ $cdWrite == "1" ]]; then
   specProcess add "CD Burner"
elif [[ $cdRead == "1" ]]; then
   specProcess add "CD Player"
fi
odd=$(specProcess return)
[ -z "$odd" ] && odd="None"
lspci=$(lspci)
vga=$(echo "$lspci" | grep -i vga | cut -d: -f3 | cut -d[ -f2 | cut -d] -f1 | sed 's/^ //' | cut -d'(' -f1 | sed "s/ Corporation//;s/ Controller//;s/\([Ii]ntegrated\)/[${highlight}m\1[m/")
#vga=$(echo "$lspci" | grep -i vga | cut -d: -f3 | cut -d] -f2 | cut -d[ -f2)
if [ -n "$(ifconfig | grep eth0)" ]; then
   nic="Onboard"
fi
if [ -n "$(iwconfig 2>&1 | grep '802.11')" ]; then
   nic="$nic + Wireless"
fi
if [ -n "$(which upower)" ]; then
  energyFull=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'energy-full:' | awk '{print $2}')
  energyFullDesign=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'energy-full-design:' | awk '{print $2}')
  if [[ $energyFull == "" || $energyFullDesign == "" ]]; then
     life="None"
  else
     life=$(bc <<< "scale=1;100*$energyFull/$energyFullDesign")"% lifetime"
  fi
else
  life="Unknown"
fi
lsusb=$(lsusb)
specProcess init
if [[ $(echo "$lsusb" | grep -i bluetooth) != "" ]]; then
   specProcess add "Bluetooth"
fi
if [[ $(echo "$lspci" | grep -i "sd host") != "" ]]; then
   specProcess add "Card Reader"
fi
if [[ $(echo "$lsusb" | grep -iE "(camera|webcam|isight)") != "" ]]; then
   specProcess add "Webcam"
fi
if [[ $(echo "$lsusb" | grep -iE "(fingerprint|biometric)") != "" ]]; then
   specProcess add "Fingerprint Reader"
fi
notes=$(specProcess return)
if [ -z "$notes" ]; then
  notes="None"
fi

# DATA OUTPUT
echo -e "Model:\t\t$mfgr$model"
echo -en "OS Installed:\t${lsbRelease}"
if   [[ $arch == "x86_64" ]]; then
   echo -e "\033[${highlight}m 64-bit\033[0m"
elif [[ $arch == "i686" ]]; then
   echo -e "\033[${highlight}m 32-bit\033[0m"
else
   echo
fi
if [[ $(echo ${cpuinfo} | grep -iE "(mhz|ghz)") == '' ]]; then
   echo -e "Processor:\t$cpuinfo @ $cpufreq"
else
   echo -e "Processor:\t$cpuinfo"
fi
echo -e "Memory:\t\t${mem}"
echo -e "Hard Drive:\t${hdd}"
echo -e "Optical Drive:\t${odd}"
echo -e "Video:\t\t${vga}"
echo -e "NIC:\t\t${nic}"
echo -e "Battery:\t${life}"
echo -e "Notes:\t\t${notes}"
