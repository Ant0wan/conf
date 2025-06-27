#!/bin/sh
#curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
set -o errexit
SCRIPTNAME="$(basename "$0")"
BIN="${SCRIPTNAME%.sh}"
VERSION=$(curl -s "https://api.github.com/repos/${BIN}/${BIN}/releases/latest" | jq -r '.tag_name')
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
TMP="/tmp/${BIN}_${VERSION}"
TARGET="${BIN}-${VERSION}-${OS}-${ARCH}.tar.gz"
mkdir -p "${TMP}"
wget "https://get.helm.sh/${TARGET}" -O "${TMP}/${TARGET}"
wget "https://get.helm.sh/${TARGET}.sha256sum" -O "${TMP}/${TARGET}.sha256sum"
SUM="$(shasum --algorithm 256 "${TMP}/${TARGET}" | awk '{print $1}')"
EXPECTED_SUM="$(awk '{print $1}' "${TMP}/${TARGET}.sha256sum")"
test "${SUM}" = "${EXPECTED_SUM}" || (echo "SHA sum of ${TARGET} does not match. Aborting."; exit 1)
tar -xzf "${TMP}/${TARGET}" -C "${TMP}"
sudo install "${TMP}/${OS}-${ARCH}/helm" /usr/local/bin/
helm version
