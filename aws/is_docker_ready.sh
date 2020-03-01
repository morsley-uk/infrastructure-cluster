#!/bin/bash

echo '###############################################################################'
echo '# IS DOCKER READY...'
echo '###############################################################################'

set -x

IsDockerRunning () {

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
    
    IsDockerRunning

    if [[ $? == 1 ]]; then
        echo "Yippee!"
        break
    fi

    sleep 1

done

docker ps

set +x

echo '###############################################################################'
echo '# DOCKER READY'
echo '###############################################################################'

exit 0