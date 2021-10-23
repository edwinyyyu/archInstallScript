#!/bin/bash

echo -n "Are you in same directory as this script? "
read checkDir
if [[ "${checkDir}" != "yes" ]]; then
    echo "Prepare things first. Exiting"
    exit 1
fi

#Install packages
pacman -Syu
pacman -S - < packageLists/packages
