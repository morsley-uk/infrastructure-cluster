#!/bin/sh

sudo apt-get update
sudo curl -fsSL https://releases.rancher.com/install-docker/19.03.5.sh -o get-docker.sh
sudo chmod +x get-docker.sh
sdo ./get-docker.sh
sudo usermod -aG docker ubuntu