#!/bin/bash

echo '###############################################################################'
echo '# IS CLUSTER READY...'
echo '###############################################################################'

set -x

IsClusterReady () {

    #state=$(systemctl show --property ActiveState docker)

    #if [[ $state == ActiveState=active ]]; then
        echo "Yes"
        return 1
    #else
    #    echo "No"
    #    return 0
    #fi

}

echo "Is cluster ready...?"

while true
do
    
    IsClusterReady

    if [[ $? == 1 ]]; then
        echo "Yippee!"
        break
    fi

    sleep 1

done

#docker ps

set +x

echo '###############################################################################'
echo '# CLUSTER READY'
echo '###############################################################################'

exit 0