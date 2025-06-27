#!/bin/sh
set -o errexit
VERSION=$(
	select VERSION in $(git ls-remote --tags https://go.googlesource.com/go | awk -F '/' '{print $3}'); do
		echo "$VERSION";
		break;
	done)
printf "\r%s\n" "${VERSION}"
SCRIPTNAME="$(basename "$0")"
BIN="${SCRIPTNAME%.sh}"
TMP="/tmp/${BIN}_${VERSION}"
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
TARGET="${VERSION}.${OS}-${ARCH}.tar.gz"
mkdir -p "$TMP"
echo "Download URL: https://go.dev/dl/${VERSION}.${OS}-${ARCH}.tar.gz"
wget "https://go.dev/dl/${VERSION}.${OS}-${ARCH}.tar.gz" -O "${TMP}/${TARGET}"
sudo tar -C "/usr/local" -xzf "${TMP}/${TARGET}"
#go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.56.2
