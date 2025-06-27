#!/bin/sh
set -o errexit
VERSION=$(curl -s "https://api.github.com/repos/aquasecurity/trivy/releases/latest" | jq -r '.tag_name')
SCRIPTNAME="$(basename "$0")"
BIN="${SCRIPTNAME%.sh}"
TMP="/tmp/${BIN}_${VERSION}"
OS="$(uname -s)"
TARGET="trivy_${VERSION#?}_${OS}-64bit.deb"
mkdir -p "$TMP"
wget "https://github.com/aquasecurity/trivy/releases/download/${VERSION}/${TARGET}" -O "${TMP}/${TARGET}"
sudo dpkg -i "${TMP}/${TARGET}"
