#!/bin/bash
set -o errexit
wget -q -O - https://get.docker.com/ | sh
sudo groupadd docker
sudo usermod -aG docker "$USER"
echo 'docker compose --compatibility "$@"' | sudo tee /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
