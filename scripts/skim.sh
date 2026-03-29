#!/bin/sh
set -o errexit
REPO="skim-rs/skim"
VERSION=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq -r '.tag_name')
ARCH="$(uname -m | sed 's/x86_64/x86_64/; s/aarch64/aarch64/')"
OS="$(uname -s | tr '[:upper:]' '[:lower:]' | sed 's/darwin/apple-darwin/; s/linux/unknown-linux-musl/')"
TARGET="skim-${ARCH}-${OS}.tar.xz"
TMP="/tmp/skim"
mkdir -p "$TMP"
curl -sL "https://github.com/${REPO}/releases/download/${VERSION}/${TARGET}" -o "${TMP}/${TARGET}"
sudo tar -xf "${TMP}/${TARGET}" -C "$TMP" --strip-components=1 "skim-${ARCH}-${OS}/sk"
sudo install "$TMP/sk" /usr/local/bin/
