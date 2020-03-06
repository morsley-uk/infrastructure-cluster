#!/bin/bash

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