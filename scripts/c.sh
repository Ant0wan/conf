#!/bin/sh
if [ -f /etc/fedora-release ]; then
	sudo dnf install -y gcc clang make lldb valgrind
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	sudo apt-get update
	sudo apt-get install -y build-essential lldb valgrind
else
	echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
	exit 1
fi
curl 'https://raw.githubusercontent.com/torvalds/linux/master/.clang-format' -o "$HOME/.clang-format"
echo "Development tools have been successfully installed."
