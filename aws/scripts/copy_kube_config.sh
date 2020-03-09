#!/bin/sh

title="Copy Cluster Config"

printf  "\n"
printf  "%0.s-" {1..80}
printf  "\n-\/- $title\n"
printf  "%0.s-" {1..80}
printf  "\n\n"

#set -x

echo "Copy the kube_config.yaml file to the .kube folder (and rename it to config)"
cp ~/rancher/kube_config.yaml ~/.kube/config --verbose

#set +x

printf  "\n"
printf  "%0.s-" {1..80}
printf  "\n-/\- $title\n"
printf  "%0.s-" {1..80}
printf  "\n\n"

exit 0