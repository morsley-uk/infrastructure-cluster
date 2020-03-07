#!/bin/bash

print_header () {
    echo '###############################################################################'
    echo '# IS CERT-MANAGER READY...?'
    echo '###############################################################################'
}

print_footer () {
    echo '###############################################################################'
    echo '# CERT-MANAGER READY?'
    echo '###############################################################################'
}

print_header

#set -x

export KUBECONFIG=$(pwd)/rancher/kube_config.yaml

#nodes_json=$(kubectl get nodes --output "json" 2>/dev/null)
##echo $nodes_json | jq .
#   
#if [ -z "$nodes_json" ]; then
#    echo "Nothing to destroy"
#    print_footer
#    exit 0
#fi
#    
#number_of_nodes=$(jq '.items | length' <<< $nodes_json)
#    
#if [[ $number_of_nodes == 0 ]]; then
#    echo "Number of Nodes: ${number_of_nodes}"
#    echo "Nothing to destroy"
#    print_footer
#    exit 0
#fi
#        
#echo "Number of Nodes: ${number_of_nodes}"
#        
#for ((i = 0 ; i < number_of_nodes ; i++)); do
#
#    node_json=$(jq --arg index ${i} '.items[$index|tonumber]' <<< $nodes_json)
#    #echo $node_json | jq .
#    
#    node_name=$(jq '.metadata.name' --raw-output <<< $node_json)
#
#    echo "Destroying node ${i}: ${node_name}"
#    
#    #kubectl drain ${node_name}
#    kubectl delete node ${node_name}
#
#done
#
#set +x

print_footer

exit 0