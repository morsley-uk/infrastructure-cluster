#!/bin/bash

echo '###############################################################################'
echo '# INSTALLING NGINX...'
echo '###############################################################################'

set -x

apt-get update

set +x

echo '###############################################################################'
echo '# NGINX INSTALLED'
echo '###############################################################################'

return 0

#sudo apt update

#sudo apt install wget

#sudo wget http://nginx.org/keys/nginx_signing.key

#sudo apt-key add nginx_signing.key

#cd /etc/apt

#sudo chmod 777 sources.list

#sudo echo 'deb http://nginx.org/packages/ubuntu xenial nginx' >> sources.list
#sudo echo 'deb-src http://nginx.org/packages/ubuntu xenial nginx' >> sources.list

#sudo apt-get update

#sudo apt-get install nginx -y

#sudo service nginx start