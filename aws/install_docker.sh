#!/bin/sh

echo '###############################################################################'
echo '# INSTALLING DOCKER...'
echo '###############################################################################'

set -x

sudo apt-get update --quiet

sudo curl -fsSL https://releases.rancher.com/install-docker/19.03.5.sh -o get-docker.sh

sudo chmod +x get-docker.sh

sudo bash get-docker.sh

sudo usermod -aG docker ubuntu

set +x

echo '###############################################################################'
echo '# DOCKER INSTALLED'
echo '###############################################################################'

exit 0