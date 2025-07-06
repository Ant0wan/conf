#!/bin/sh
wget https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi --output-document=/tmp/bitwarden.xpi
firefox /tmp/bitwarden.xpi
#wget https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi --output-document=/tmp/ghostery.xpi
#firefox /tmp/ghostery.xpi
wget https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi --output-document=/tmp/ublock.xpi
firefox /tmp/ublock.xpi

#if [ "$(basename $(pwd))" = "scripts" ]; then
#	cp -f "$(dirname $(pwd))"/user.js "$HOME"/.mozilla/firefox/*.default-esr/
#elif test -e "$0"; then
#	cp -f user.js "$HOME"/.mozilla/firefox/*.default-esr/
#else
#	githubsource="https://raw.githubusercontent.com/Ant0wan/conf/main/"
#	wget "${githubsource}user.js" -O "$HOME"/.mozilla/firefox/*.default-esr/
#fi

# Non-essentials extensions (streaming)
#wget https://addons.mozilla.org/firefox/downloads/latest/video-downloadhelper/latest.xpi --output-document=/tmp/downloadhelper.xpi
#firefox /tmp/downloadhelper.xpi
#curl -sSLf https://github.com/aclap-dev/vdhcoapp/releases/latest/download/install.sh | bash
