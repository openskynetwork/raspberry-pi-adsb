#!/bin/bash
cd ~
sudo apt-get install cmake libusb-1.0-0-dev build-essential
git clone git://git.osmocom.org/rtl-sdr.git
cd rtl-sdr
mkdir build
cd build
cmake ../ -DINSTALL_UDEV_RULES=ON
make
sudo make install
sudo ldconfig
sudo cp rtl-sdr.rules /etc/udev/rules.d/
cd ~/adsb-base-station
sudo cp nortl.conf /etc/modprobe.d/
DEFAULT="y"
read -e -p "OK to reboot the system [Y/n]?" PROCEED
PROCEED="${PROCEED:-${DEFAULT}}"
PROCEED="${PROCEED,,}"
if [ "${PROCEED}" == "y" ] ; then
  echo "Rebooting."
  sudo reboot
else
  echo "Reboot cancelled."
fi