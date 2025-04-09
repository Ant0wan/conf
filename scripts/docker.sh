#!/bin/bash
set -o errexit
wget -q -O - https://get.docker.com/ | sh
sudo groupadd docker
sudo usermod -aG docker "$USER"
sudo install "$(dirname "${BASH_SOURCE[0]}")/../conf/docker-compose" /usr/local/bin/docker-compose
