#!/bin/sh
if [ -f /etc/fedora-release ]; then
	sudo dnf config-manager addrepo --from-repofile=https://downloads.k8slens.dev/rpm/lens.repo
	sudo dnf install lens -y
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | sudo tee /etc/apt/sources.list.d/lens.list > /dev/null
	sudo apt update && sudo apt install lens -y
else
	echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
	exit 1
fi
echo "Lens or Kuberneters has been successfully installed."
