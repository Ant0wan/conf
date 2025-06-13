#!/bin/sh
set -o errexit
VERSION=$(curl -s "https://api.github.com/repos/kubernetes-sigs/cri-tools/releases/latest" | jq -r '.tag_name')
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
OS="$(uname -s | awk '{print tolower($0)}')"
TARGET="crictl.tar.gz"
TMP="/tmp/crictl"
mkdir -p "$TMP"
curl -sL "https://github.com/kubernetes-sigs/cri-tools/releases/download/${VERSION}/crictl-${VERSION}-${OS}-${ARCH}.tar.gz" > "${TMP}/${TARGET}"
sudo tar -zxvf "${TMP}/${TARGET}" -C /usr/local/bin/ crictl
