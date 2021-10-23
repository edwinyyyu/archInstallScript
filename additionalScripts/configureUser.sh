#!/bin/bash

#i3
echo "exec i3" > ~/.xinitrc
mkdir ~/.config/i3
cat configFiles/.config/i3/config > ~/.config/i3/config

#vim
cat configFiles/.vimrc > ~/.vimrc

#Miscellaneous
xdg-user-dirs-update
gsettings set org.gnome.desktop.interface monospace-font-name "Noto Sans Mono 10"
gsettings set org.x.editor.preferences.editor restore-cursor-position false
