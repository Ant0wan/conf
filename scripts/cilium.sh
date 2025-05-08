#!/bin/bash
OS="$(uname -s | awk '{print tolower($0)}')"
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH="$(uname -m | sed 's/x86_64/amd64/')"
if [ "$(uname -m)" = "aarch64" ]; then CLI_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-${OS}-${CLI_ARCH}.tar.gz{,.sha256sum}
sha256sum --check cilium-${OS}-${CLI_ARCH}.tar.gz.sha256sum
sudo tar xzvfC cilium-${OS}-${CLI_ARCH}.tar.gz /usr/local/bin
rm cilium-${OS}-${CLI_ARCH}.tar.gz{,.sha256sum}
