#!/bin/sh
set -o errexit
set -o nounset
OS="$(uname -s | awk '{print tolower($0)}')"
ARCH="$(uname -m | sed 's/x86_64/amd64/')"
githubsource="https://raw.githubusercontent.com/Ant0wan/conf/main/"
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-${OS}-${ARCH} -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh
oh-my-posh font install Meslo
oh-my-posh get shell
wget "${githubsource}theme.omp.json" -O "$HOME"/.theme.omp.json
