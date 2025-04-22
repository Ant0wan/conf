#!/bin/sh
if [ -f /etc/fedora-release ]; then
	sudo yum install tmux
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	sudo apt update
	sudo apt install tmux -y -q
else
  echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
  exit 1
fi
echo "Tmux has been successfully installed."
