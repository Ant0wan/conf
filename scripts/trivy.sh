#!/bin/sh
set -o errexit
REPO="aquasecurity/trivy"
VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.tag_name' | tr -d 'v')
ARCH="$(uname -m | sed 's/x86_64/64bit/; s/aarch64/ARM64/')"
OS="$(uname -s | tr '[:upper:]' '[:lower:]' | sed 's/linux/Linux/; s/darwin/macOS/')"
TARGET="trivy_${VERSION}_${OS}-${ARCH}.tar.gz"
TMP="/tmp/trivy"
mkdir -p "$TMP"
curl -sL "https://github.com/${REPO}/releases/download/v${VERSION}/${TARGET}" -o "${TMP}/${TARGET}"
sudo tar -xzf "${TMP}/${TARGET}" -C "$TMP" trivy
sudo install "$TMP/trivy" /usr/local/bin/
