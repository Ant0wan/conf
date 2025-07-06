#!/bin/sh
wget https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi --output-document=/tmp/bitwarden.xpi
firefox /tmp/bitwarden.xpi
wget https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi --output-document=/tmp/ghostery.xpi
firefox /tmp/ghostery.xpi
wget https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi --output-document=/tmp/ublock.xpi
firefox /tmp/ublock.xpi

# Non-essentials extensions
#wget https://addons.mozilla.org/firefox/downloads/latest/video-downloadhelper/latest.xpi --output-document=/tmp/downloadhelper.xpi
#firefox /tmp/downloadhelper.xpi
#curl -sSLf https://github.com/aclap-dev/vdhcoapp/releases/latest/download/install.sh | bash
