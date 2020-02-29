#!/bin/bash

#apt-get update 
#curl -fsSL ${docker_install_url} -o get-docker.sh | sh
#usermod -aG docker ubuntu

#sudo curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
#sudo usermod -aG docker ubuntu

# From Docker...

# https://docs.docker.com/install/linux/docker-ce/ubuntu/

sudo apt-get update

sudo apt-get install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg-agent \
     software-properties-common -y

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sudo usermod -aG docker ubuntu