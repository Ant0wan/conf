#!/bin/sh
set -o errexit
ARCH="$(uname -m)"
URL="https://storage.googleapis.com/gvisor/releases/release/latest/${ARCH}"
wget "${URL}/runsc" "${URL}/runsc.sha512" "${URL}/containerd-shim-runsc-v1" "${URL}/containerd-shim-runsc-v1.sha512"
sha512sum -c runsc.sha512 -c containerd-shim-runsc-v1.sha512
rm -f *.sha512
chmod a+rx runsc containerd-shim-runsc-v1
sudo mv runsc containerd-shim-runsc-v1 /usr/local/bin
sudo /usr/local/bin/runsc install
if command -v docker >/dev/null 2>&1; then
	sudo systemctl restart docker
	docker run --rm --runtime=runsc hello-world
fi
