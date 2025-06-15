#!/bin/sh
set -o errexit
VERSION=$(curl -s "https://api.github.com/repos/cert-manager/cmctl/releases/latest" | jq -r '.tag_name')
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
OS="$(uname -s | awk '{print tolower($0)}')"
sudo curl --silent --location "https://github.com/cert-manager/cmctl/releases/download/${VERSION}/cmctl_${OS}_${ARCH}" --output /usr/local/bin/cmctl
sudo chmod +x /usr/local/bin/cmctl
