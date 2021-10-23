#!/bin/bash

echo -n "Is the machine connected to the internet? "
read checkDir
if [[ "${checkDir}" != "yes" ]]; then
    echo "Prepare things first. Exiting"
    exit 1
fi

sudo ./additionalScripts/pacInstall.sh
./additionalScripts/aurInstall.sh
sudo ./additionalScripts/configureRoot.sh
./additionalScripts/configureUser.sh
