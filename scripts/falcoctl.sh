#!/bin/sh
set -o errexit
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
LATEST=$(curl -sI https://github.com/falcosecurity/falcoctl/releases/latest | awk '/location: /{gsub("\r","",$2);split($2,v,"/");print substr(v[8],2)}')
TARGET="falcoctl.tar.gz"
TMP="/tmp/falco"
mkdir -p "$TMP"
curl -sL "https://github.com/falcosecurity/falcoctl/releases/download/v${LATEST}/falcoctl_${LATEST}_${OS}_${ARCH}.tar.gz" > "${TMP}/${TARGET}"
sudo tar -zxvf "${TMP}/${TARGET}" -C /usr/local/bin/ falcoctl
