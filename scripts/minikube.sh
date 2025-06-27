#!/bin/sh
set -o errexit
SCRIPTNAME="$(basename "$0")"
BIN="${SCRIPTNAME%.sh}"
TMP="/tmp/${BIN}"
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
mkdir -p "$TMP"
wget "https://storage.googleapis.com/minikube/releases/latest/minikube-${OS}-${ARCH}" -O "${TMP}/minikube"
sudo install -o root -g root -m 0755 "${TMP}/minikube" /usr/local/bin/minikube
