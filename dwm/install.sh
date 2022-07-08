#!/bin/bash

function PrepareConfig {

	read -p "Enter Linux user " USER1; echo
	
	read -p "Is $USER1 correct? (Y/y)" -n 1 -r; echo
	
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		
		cp config/bg/M2020G2.jpg /home/$USER1/
		
		cp config/dmenu-status/time /home/$USER1/
		
		echo "Authentication required to copy custom dwm launch script to /bin and xsession file to /usr/share/xsessions"

		sed -i "s/USER/$USER1/" config/bin/dwm-custom

		sudo cp config/bin/dwm-custom /bin/
		
		sudo cp config/xsessions/* /usr/share/xsessions/
		
	else
		PrepareConfig
	fi

}

echo "Authentication required to build and install dwm and dependencies"

sudo pacman -S base-devel make libxinerama freetype2 libxft sed dmenu feh geoip geoip-database bind xorg-server xorg-xsetroot

sudo make clean install

PrepareConfig

echo "Done"
