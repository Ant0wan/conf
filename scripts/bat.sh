#!/bin/sh
set -o errexit
REPO="sharkdp/bat"
VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.tag_name')
ARCH="$(uname -m)"
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$OS" in
  linux)
    OS="unknown-linux-musl"
    ;;
  darwin)
    OS="apple-darwin"
    ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac
TARGET="bat-${VERSION}-${ARCH}-${OS}.tar.gz"
TMP="/tmp/bat"
mkdir -p "$TMP"
curl -sL "https://github.com/${REPO}/releases/download/${VERSION}/${TARGET}" -o "${TMP}/${TARGET}"
sudo tar -xzf "${TMP}/${TARGET}" -C "$TMP" --strip-components=1 "bat-${VERSION}-${ARCH}-${OS}/bat"
sudo install "$TMP/bat" /usr/local/bin/
