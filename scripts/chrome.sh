#!/bin/sh
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
NAME="google-chrome-stable_current_${ARCH}"
if [ -f /etc/fedora-release ]; then
	wget https://dl.google.com/${OS}/direct/${NAME}.rpm -O /tmp/${NAME}.rpm
	sudo dnf install -y /tmp/${NAME}.rpm
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	wget https://dl.google.com/${OS}/direct/${NAME}.deb -O /tmp/${NAME}.deb
	sudo apt install -y /tmp/${NAME}.deb
else
  echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
  exit 1
fi
echo "Chrome has been successfully installed."
