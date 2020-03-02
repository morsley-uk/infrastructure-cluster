#!/bin/bash

echo '###############################################################################'
echo '# IS CLUSTER READY...'
echo '###############################################################################'

#set -x

export KUBECONFIG=$(pwd)/kube_config_rancher-cluster.yaml

is_cluster_ready () {

    nodes_json=$(kubectl get nodes --output "json")
    number_of_nodes=$(jq '.items | length' <<< $nodes_json)
    echo "Number of Nodes: ${number_of_nodes}"
    
    for ((i = 0 ; i < $number_of_nodes ; i++))
    do
        node_json=$(jq --arg i ${i} '.items[$i|tonumber]' <<< $nodes_json)
        #echo $node_json | jq .
        node_name=$(jq '.metadata.name' <<< $node_json)
        node_status=$(jq '.status.conditions[] | select(.reason == "KubeletReady") | .type' <<< $node_json)
        echo "Node ${i+1}: ${node_name}"
        echo "Status: ${node_status}"
    done
    

    if [ ${node_status} == '"Ready"' ]; then
        echo "Yes"
        return 1
    else
        echo "No"
        return 0
    fi

}



echo "Is cluster ready...?"

while true
do
    
    is_cluster_ready

    if [[ $? == 1 ]]; then
        echo "Yippee!"
        break
    fi

    sleep 1

done

#docker ps

#set +x

echo '###############################################################################'
echo '# CLUSTER READY'
echo '###############################################################################'

exit 0