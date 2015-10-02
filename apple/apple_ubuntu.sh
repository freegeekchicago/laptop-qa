#!/bin/bash

## Define Variables
MODEL=`dmidecode -s system-product-name`
MACBOOK21='MacBook2,1'
MACBOOK41='MacBook4,1'

## Report Apple Model
if [ $MODEL = $MACBOOK41 ]; then
    echo "You are using an Apple $MODEL."

## Install webcam firmware
    apt-get install isight-firmware-tools
    wget http://fgc-nfs/iSight/AppleUSBVideoSupport /lib/firmware
    ift-extract -a /lib/firmware/AppleUSBVideoSupport

## Fix touchpad issues
### Current session
    synclient FingerLow=10
    synclient FingerHigh=20
### Permanently
    if [ ! -d "/etc/X11/xorg.conf.d" ]; then
        mkdir /etc/X11/xorg.conf.d
    fi
 
    echo 'Section "InputClass"
    Identifier "touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Driver "synaptics"
    Option "FingerLow" "10"
    Option "FingerHigh" "20"
EndSection' >> /etc/X11/xorg.conf.d/10-synaptics.conf

### Install Broadcom Wireless Driver
    apt-get install firmware-b43-installer b43-fwcutter

fi

## Report Apple Model
if [ $MODEL = $MACBOOK21 ]; then
    echo "You are using an Apple $MODEL."

## Install webcam firmware
    apt-get install isight-firmware-tools
    cp AppleUSBVideoSupport /lib/firmware
    ift-extract -a /lib/firmware/AppleUSBVideoSupport

## Fix touchpad issues
### Current session
    synclient FingerLow=10
    synclient FingerHigh=20
### Permanently
    if [ ! -d "/etc/X11/xorg.conf.d" ]; then
        mkdir /etc/X11/xorg.conf.d
    fi

    echo 'Section "InputClass"
    Identifier "touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Driver "synaptics"
    Option "FingerLow" "10"
    Option "FingerHigh" "20"
EndSection' >> /etc/X11/xorg.conf.d/10-synaptics.conf

fi
