#!/bin/bash

currentDir="$(pwd)"
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd "${currentDir}"

yay -S - < packageLists/aurPackages
