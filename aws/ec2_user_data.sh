#!/bin/bash
 
curl -fsSL ${docker_install_url} -o get-docker.sh
sudo chmod +x get-docker.sh
./get-docker.sh
sudo usermod -aG docker ubuntu
