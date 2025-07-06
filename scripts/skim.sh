#!/bin/sh
if [ -f /etc/fedora-release ]; then
  sudo dnf install -y skim
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	sudo apt install curl -yq
	mkdir -p /tmp/skim/
	cd /tmp/skim
	wget -qO-  https://raw.githubusercontent.com/lotabout/skim/master/install | bash
	sudo install bin/sk /usr/local/bin
else
  echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
  exit 1
fi
echo "Skim has been successfully installed."
