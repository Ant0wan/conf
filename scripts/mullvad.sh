#!/bin/sh
if [ -f /etc/fedora-release ]; then
	sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
	echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list
	sudo apt update
	sudo apt install mullvad-vpn
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	sudo dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
	sudo dnf config-manager --add-repo https://repository.mullvad.net/rpm/stable/mullvad.repo
	sudo dnf install mullvad-vpn
else
  echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
  exit 1
fi
echo "Mullvad has been successfully installed."
