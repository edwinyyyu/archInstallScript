/#!/bin/bash

#Swappiness
echo "vm.swappiness=0" > /etc/sysctl.d/99-swappiness.conf

#Bluetooth
vim -i NONE /etc/bluetooth/main.conf
systemctl enable bluetooth.service

#CUPS
systemctl mask systemd-resolved.service
systemctl enable avahi-daemon.service
systemctl enable cups.socket
vim -i NONE /etc/nsswitch.conf
systemctl restart avahi-daemon.service
systemctl restart cups.service

#i3
cat configFiles/etc/i3status.conf > /etc/i3status.conf

#intel-undervolt
vim -i NONE /etc/intel-undervolt.conf
intel-undervolt apply
intel-undervolt read
systemctl enable intel-undervolt.service

#LightDM
vim -i NONE /etc/lightdm/lightdm.conf
systemctl enable lightdm.service

#ntp
cat configFiles/etc/ntp.conf > /etc/ntp.conf
systemctl enable ntpd.service

#picom
vim -i NONE /etc/xdg/picom.conf

#tlp
vim -i NONE /etc/tlp.conf
systemctl mask systemd-rfkill.service
systemctl mask systemd-rfkill.socket
systemctl enable NetworkManager-dispatcher.service
systemctl enable tlp.service
tlp start

#vim
cat configFiles/.vimrc > ~/.vimrc

#Miscellaneous
mkdir /etc/X11
mkdir /etc/X11/xorg.conf.d
cp -r configFiles/etc/X11/xorg.conf.d /etc/X11
cp -r additionalFiles/usr /
fc-cache --force
