echo sudo apt-get install isight-firmware-tools
here="$(dirname ${0})"
echo cp "$here"/../Webcams/iSight/AppleUSBVideoSupport /lib/firmware
echo sudo ift-extract -a /lib/firmware/AppleUSBVideoSupport
