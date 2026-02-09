#!/bin/sh
if [ -f /etc/fedora-release ]; then
  sudo dnf copr enable dirkhh/Subsurface-test
  sudo dnf install -y subsurface
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
  sudo add-apt-repository ppa:subsurface/subsurface-daily
  sudo apt-get update
  sudo apt-get install -y subsurface
else
  echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
  exit 1
fi
echo "SubSurface has been successfully installed."
