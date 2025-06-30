#!/bin/sh
if command -v bw >/dev/null 2>&1; then
	echo "BitWarden is already installed."
	exit 0
fi
set -o errexit
wget 'https://vault.bitwarden.com/download/?app=cli&platform=linux' -O bw-cli.zip
unzip bw-cli.zip
rm bw-cli.zip
chmod +x bw
sudo mv bw /usr/local/bin/
bw login
bw logout
