#!/bin/bash

echo -n "Are you in same directory as this script? "
read checkDir
echo -n "Has the intended installation drive been cleared? "
read checkPrep
if [[ "${checkDir}" != "yes" || "${checkPrep}" != "yes" ]]; then
    echo "Prepare things first. Exiting"
    exit 1
fi

#Connect to the internet
iwctl
ping archlinux.org

#Update the system clock
timedatectl set-ntp true

#Select the installation drive
efibootmgr
lsblk
echo -n "Select installation drive. Express as \"/dev/sdX\": "
read drive

#Partition the drive
cfdisk -z "${drive}"

#Format the partitions
mkfs.fat -F32 "${drive}1"
mkfs.ext4 "${drive}2"

#Mount the file systems
mount "${drive}2" /mnt
mkdir /mnt/boot
mount "${drive}1" /mnt/boot

#Install essential packages
pacstrap /mnt base base-devel linux linux-firmware

#Fstab
genfstab -U /mnt >> /mnt/etc/fstab
vim -i NONE /mnt/etc/fstab

echo -n "Continue to chroot? "
read checkChroot
if [[ "${checkChroot}" != "yes" ]]; then
    echo "Exiting"
    exit 1
fi

#Chroot
cp additionalScripts/archChroot.sh /mnt
arch-chroot /mnt ./archChroot.sh "${drive}"
rm /mnt/archChroot.sh
