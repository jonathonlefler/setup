#!/bin/bash
echo "Initializing $1"
cd /home/pi
echo "Downloading git"
apt install git
echo "Downloading LMIC"
git clone https://github.com/wklenk/lmic-rpi-lora-gps-hat.git
chown -R pi:pi lmic-rpi-lora-gps-hat
echo "Downloading WiringPi"
git clone git://git.drogon.net/wiringPi
echo "Installing WiringPi"
cd /home/pi/wiringPi
git pull origin
./build
cd
chown -R pi:pi wiringPi
echo "Enabling SSH."
systemctl enable ssh
echo "Changing keyboard layout"
sed -i -e 's/XKBLAYOUT="gb"/XKBLAYOUT="us"/g' /etc/default/keyboard
echo "Changing Hostname"
sed -i -e "s/raspberrypi/$1/g" /etc/hostname
sed -i -e "s/raspberrypi/$1/g" /etc/hosts
reboot
