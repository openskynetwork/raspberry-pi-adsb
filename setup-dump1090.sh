#!/bin/bash
sudo apt-get install pkg-config
cd ~
git clone git://github.com/MalcolmRobb/dump1090.git
cd dump1090
make
cd ~/adsb-base-station
sudo cp dump1090.sh /etc/init.d/
sudo chmod +x /etc/init.d/dump1090.sh
sudo update-rc.d dump1090.sh defaults
read -e -p "OK to reboot the system [Y/n]?" PROCEED
PROCEED="${PROCEED:-${DEFAULT}}"
PROCEED="${PROCEED,,}"
if [ "${PROCEED}" == "y" ] ; then
  echo "Rebooting."
  sudo reboot
else
  echo "Reboot cancelled."
fi