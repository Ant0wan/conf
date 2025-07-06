#!/bin/bash
su -c - root 'echo "antoine ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/antoine'

dconf write /org/gnome/desktop/sound/event-sounds "false"
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.Terminal.Legacy.Settings theme-variant 'dark'

su -c - root '
echo "deb https://deb.debian.org/debian/ bookworm non-free contrib main non-free-firmware
deb-src https://deb.debian.org/debian/ bookworm non-free contrib main non-free-firmware #Added by software-properties
deb https://deb.debian.org/debian/ bookworm-proposed-updates main non-free-firmware non-free contrib
" > /etc/apt/sources.list && apt update'

if [ "$(basename $(pwd))" = "scripts" ]; then
	cp -f "$(dirname $(pwd))"/user-dirs.dirs "$HOME"/.config/user-dirs.dirs
elif test -e "$0"; then
	cp -f user-dirs.dirs "$HOME"/.config/user-dirs.dirs
else
	githubsource="https://raw.githubusercontent.com/Ant0wan/conf/main/"
	wget "${githubsource}user-dirs.dirs" -O "$HOME"/.config/user-dirs.dirs
fi
rm -rf ~/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
