#!/bin/bash

echo '###############################################################################'
echo '# IS DOCKER READY...'
echo '###############################################################################'

#set -x

is_docker_running () {

    state=$(systemctl show --property ActiveState docker)

    if [[ $state == ActiveState=active ]]; then
        echo "Yes"
        return 1
    else
        echo "No"
        return 0
    fi

}

echo "Is Docker ready...?"

while true
do
    
    is_docker_running

    if [[ $? == 1 ]]; then
        echo "Yippee!"
        break
    fi

    sleep 1

done

docker ps

#set +x

echo '###############################################################################'
echo '# DOCKER READY'
echo '###############################################################################'

exit 0