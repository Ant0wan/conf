#!/bin/bash
dconf write /org/gnome/desktop/sound/event-sounds "false" 
su -c - root 'echo "antoine ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/antoine'
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'
su -c - root '
echo "deb https://deb.debian.org/debian/ bookworm non-free contrib main non-free-firmware
deb-src https://deb.debian.org/debian/ bookworm non-free contrib main non-free-firmware #Added by software-properties
deb https://deb.debian.org/debian/ bookworm-proposed-updates main non-free-firmware non-free contrib
" > /etc/apt/sources.list && apt update'
su - -c root 'timedatectl set-timezone Europe/Paris'
