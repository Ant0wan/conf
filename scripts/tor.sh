#!/bin/sh
set -x
set -o errexit
VERSION=$(
	select VERSION in $(curl --silent https://dist.torproject.org/torbrowser/ | grep -oP 'href="\K[0-9]+[^/]*' | sort -u); do
		echo "$VERSION";
		break;
	done)
printf "\r%s\n" "${VERSION}"
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m)"
TMP="/tmp/tor-browser-${OS}-${ARCH}-${VERSION}.tar.xz"
curl -sL "https://www.torproject.org/dist/torbrowser/${VERSION}/tor-browser-${OS}-${ARCH}-${VERSION}.tar.xz" > ${TMP}
sudo tar -xvf ${TMP} -C /opt/
sudo chown -R $USER:$USER /opt/tor-browser/
echo 'bash -c "pushd /opt/tor-browser; ./start-tor-browser.desktop"' | sudo tee /usr/local/bin/tor
sudo chmod +x /usr/local/bin/tor
