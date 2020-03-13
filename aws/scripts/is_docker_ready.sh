#!/bin/bash

#    _____       _____             _               _____                _      ___  
#   |_   _|     |  __ \           | |             |  __ \              | |    |__ \ 
#     | |  ___  | |  | | ___   ___| | _____ _ __  | |__) |___  __ _  __| |_   _  ) |
#     | | / __| | |  | |/ _ \ / __| |/ / _ \ '__| |  _  // _ \/ _` |/ _` | | | |/ / 
#    _| |_\__ \ | |__| | (_) | (__|   <  __/ |    | | \ \  __/ (_| | (_| | |_| |_|  
#   |_____|___/ |_____/ \___/ \___|_|\_\___|_|    |_|  \_\___|\__,_|\__,_|\__, (_)  
#                                                                          __/ |    
#                                                                         |___/     

title="Is Docker ready?"

printf  "\n"
printf  "%0.s-" {1..80}
printf  "\n-\/- $title\n"
printf  "%0.s-" {1..80}
printf  "\n\n"

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
        break
    fi

    sleep 1

done

printf "%0.s-" {1..80}
printf "\n"
echo "docker ps --all"
printf "%0.s-" {1..80}
printf "\n"
docker ps
printf "%0.s-" {1..80}
printf "\n"

#set +x

printf  "\n"
printf  "%0.s-" {1..80}
printf  "\n-/\- $title\n"
printf  "%0.s-" {1..80}
printf  "\n\n"

exit 0