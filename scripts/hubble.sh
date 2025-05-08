#!/bin/bash
OS="$(uname -s | awk '{print tolower($0)}')"
HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
HUBBLE_ARCH="$(uname -m | sed 's/x86_64/amd64/')"
if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-${OS}-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
sha256sum --check hubble-${OS}-${HUBBLE_ARCH}.tar.gz.sha256sum
sudo tar xzvfC hubble-${OS}-${HUBBLE_ARCH}.tar.gz /usr/local/bin
rm hubble-${OS}-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
