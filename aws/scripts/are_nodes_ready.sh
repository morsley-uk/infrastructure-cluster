#!/bin/bash

export KUBECONFIG=rke/kube_config.yaml

bash header.sh "Are Node(s) Up?"

are_nodes_ready () {

    nodes_json=$(kubectl get nodes --output "json" 2>/dev/null)
    
    if [ -z "$nodes_json" ]; then
      echo "No"
      return 0
    fi
    
    number_of_nodes=$(jq '.items | length' <<< $nodes_json)
    
    if [[ $number_of_nodes == 0 ]]; then
        echo "No - Number of Nodes: ${number_of_nodes}"
        return 0
    fi
    
    feedback="Number of Nodes: ${number_of_nodes} | "
    
    for ((i = 0 ; i < number_of_nodes ; i++))
    do
        node_json=$(jq --arg i ${i} '.items[$i|tonumber]' <<< $nodes_json)
        #echo $node_json | jq .
        node_name=$(jq '.metadata.name' <<< $node_json)
        node_status=$(jq '.status.conditions[] | select(.reason == "KubeletReady") | .type' <<< $node_json)
        #echo "Node ${i+1}: ${node_name}"
        #echo "Status: ${node_status}"
        feedback+="Node $((i+1)): ${node_name} | Status: ${node_status}"
    done
    

    if [ "${node_status}" == '"Ready"' ]; then
        echo "[ YES ]"
        bash divider.sh
        echo "Nodes"
        bash divider.sh
        kubectl get nodes
        bash divider.sh
        return 1
    fi
    echo "No - $feedback"
    return 0

}


while true; do
    
    are_nodes_ready

    if [[ $? == 1 ]]; then
        break
    fi

    sleep 1

done

bash footer.sh "Are Node(s) Up?"