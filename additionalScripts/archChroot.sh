#!/bin/bash

#Get machine, owner
echo -n "Machine: "
read machine
echo -n "Owner: "
read owner
hostname="${owner}-${machine}"

#Install vim
pacman -S vim

#Time zone
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc

#Localization
vim -i NONE /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

#Network configuration
echo "${hostname}" > /etc/hostname
echo "${hostname}" > /etc/hostname
echo -e "127.0.0.1\tlocalhost" >> /etc/hosts
echo -e "::1\t\tlocalhost" >> /etc/hosts
echo -e "127.0.1.1\t${hostname}.localdomain ${hostname}"

pacman -S networkmanager
systemctl enable NetworkManager.service
systemctl start NetworkManager.service

#Root password
passwd

#EFISTUB
pacman -S efibootmgr intel-ucode
for i in {0..9}; do
    efibootmgr -b "000${i}" -B
done
efibootmgr --disk "${1}" --part 1 --create --label "Arch Linux" --loader /vmlinuz-linux --unicode "root=UUID=$(blkid -s UUID -o value ${1}2) rw initrd=\intel-ucode.img initrd=\initramfs-linux.img" --verbose

#Add user
useradd -m -g users -G wheel "${owner}"

#User password
passwd "${owner}"

#Sudoers
EDITOR="vim -i NONE" visudo
