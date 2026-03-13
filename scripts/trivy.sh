#!/bin/sh
set -o errexit
VERSION=$(curl -s "https://api.github.com/repos/aquasecurity/trivy/releases/latest" | jq -r '.tag_name')
SCRIPTNAME="$(basename "$0")"
BIN="${SCRIPTNAME%.sh}"
TMP="/tmp/${BIN}_${VERSION}"
OS="$(uname -s)"
mkdir -p "$TMP"
if [ -f /etc/fedora-release ]; then
	TARGET="trivy_${VERSION#?}_${OS}-64bit.rpm"
elif [ -f /etc/lsb-release ] || [ -f /etc/os-release ] ; then
	TARGET="trivy_${VERSION#?}_${OS}-64bit.deb"
else
	echo "Unsupported distribution. This script only supports Fedora and Ubuntu."
	exit 1
fi
wget "https://github.com/aquasecurity/trivy/releases/download/${VERSION}/${TARGET}" -O "${TMP}/${TARGET}"
if [ -f /etc/fedora-release ]; then
	sudo dnf --assumeyes --quiet install "${TMP}/${TARGET}"
else [ -f /etc/lsb-release ] || [ -f /etc/os-release ]
	sudo dpkg -i "${TMP}/${TARGET}"
fi
