#!/bin/sh
set -o errexit
LATEST_VERSION=$(wget -O - "https://api.github.com/repos/open-policy-agent/conftest/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | cut -c 2-)
ARCH=$(arch)
SYSTEM=$(uname)
TMP="/tmp/conftest"
mkdir -p "$TMP"
wget "https://github.com/open-policy-agent/conftest/releases/download/v${LATEST_VERSION}/conftest_${LATEST_VERSION}_${SYSTEM}_${ARCH}.tar.gz" -P "$TMP"
tar xzf "$TMP/conftest_${LATEST_VERSION}_${SYSTEM}_${ARCH}.tar.gz" -C "$TMP"
sudo mv "$TMP/conftest" /usr/local/bin
