#!/bin/sh

title="Installing Docker"

printf  "\n"
printf  "%0.s-" {1..80}
printf  "\n-\/- $title\n"
printf  "%0.s-" {1..80}
printf  "\n\n"

#set -x

sudo apt-get update --quiet

sudo curl -fsSL https://releases.rancher.com/install-docker/19.03.5.sh -o get-docker.sh

sudo chmod +x get-docker.sh

sudo bash get-docker.sh

sudo usermod -aG docker ubuntu

#set +x

printf  "\n"
printf  "%0.s-" {1..80}
printf  "\n-/\- $title\n"
printf  "%0.s-" {1..80}
printf  "\n\n"

exit 0