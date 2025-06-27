#!/bin/sh
set -o errexit
VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
SCRIPTNAME="$(basename "$0")"
BIN="${SCRIPTNAME%.sh}"
TMP="/tmp/${BIN}_${VERSION}"
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
URL="https://dl.k8s.io/release/${VERSION}/bin/${OS}/${ARCH}/kubectl"
mkdir -p "$TMP"
wget "${URL}" -O "${TMP}/kubectl"
wget "${URL}.sha256" -O "${TMP}/kubectl.sha256"
echo "$(cat "${TMP}/kubectl.sha256")  ${TMP}/kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 "${TMP}/kubectl" /usr/local/bin/kubectl
