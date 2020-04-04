#!/bin/sh

#    _____           _        _ _   _____             _             
#   |_   _|         | |      | | | |  __ \           | |            
#     | |  _ __  ___| |_ __ _| | | | |  | | ___   ___| | _____ _ __ 
#     | | | '_ \/ __| __/ _` | | | | |  | |/ _ \ / __| |/ / _ \ '__|
#    _| |_| | | \__ \ || (_| | | | | |__| | (_) | (__|   <  __/ |   
#   |_____|_| |_|___/\__\__,_|_|_| |_____/ \___/ \___|_|\_\___|_|   
#                                                                 
                                                                 
echo '###############################################################################'
echo '# Installing Docker...'
echo '###############################################################################'

#set -x

#sudo apt-get update --quiet

#sudo curl -fsSL https://releases.rancher.com/install-docker/19.03.5.sh -o get-docker.sh

#sudo chmod +x get-docker.sh

#sudo bash get-docker.sh

curl https://releases.rancher.com/install-docker/19.03.sh | sh

sudo usermod -aG docker ubuntu

#set +x

echo '###############################################################################'
echo '# Docker Installed'
echo '###############################################################################'

exit 0