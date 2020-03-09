#!/bin/bash

print_header () {
    echo '###############################################################################'
    echo '# DESTROYING CLUSTER...'
    echo '###############################################################################'
}

print_footer () {
    echo '###############################################################################'
    echo '# CLUSTER DESTROYED'
    echo '###############################################################################'
}

print_divider () {
    echo '-------------------------------------------------------------------------------'
}

print_header

#set -x

export KUBECONFIG=~/rancher/kube_config.yaml

echo "NAMESPACES"
print_divider
kubectl get namespaces
print_divider

echo "DEPLOYMENTS"
print_divider
kubectl get deployments --all-namespaces
print_divider

echo "PODS"
print_divider
kubectl get pods --all-namespaces
print_divider

echo "SERVICES"
print_divider
kubectl get services --all-namespaces
print_divider

echo "Let's try bringing down the pods..."


deployments_json=$(kubectl get deployments --all-namespaces --output "json" 2>/dev/null)
#echo $deployments_json | jq .

#nodes_json=$(kubectl get nodes --output "json" 2>/dev/null)
##echo $nodes_json | jq .
   
if [ -z "$deployments_json" ]; then
    echo "Cannot get any deployment data!"
    print_footer
    exit 0
fi
    
number_of_deployments=$(jq '.items | length' <<< $deployments_json)

if [[ $number_of_deployments == 0 ]]; then
    echo "Number of Deployments: ${number_of_deployments}"
    echo "Nothing to destroy!"
    print_footer
    exit 0
fi
        
echo "Number of Deployments: ${number_of_deployments}"
 
for ((i = 0 ; i < number_of_deployments ; i++)); do
#for ((i = 0 ; i < 1 ; i++)); do

    deployment_json=$(jq --arg index ${i} '.items[$index|tonumber]' <<< $deployments_json)
    echo $deployment_json | jq .
    
    name=$(jq '.metadata.name' --raw-output <<< $deployment_json)
    echo $name

    namespace=$(jq '.metadata.namespace' --raw-output <<< $deployment_json)
    echo $namespace

    #conditions_json=$(jq '.status.conditions' <<< $pod_json)
    #echo $conditions_json | jq .

    #phase=$(jq '.status.phase' --raw-output <<< $pod_json)
    #echo $phase

    kubectl delete deployment ${name} --cascade=true --namespace=${namespace} 

#    echo "Destroying node ${i}: ${node_name}"
#    
#    #kubectl drain ${node_name}
#    kubectl delete node ${node_name}

done

#set +x

print_footer

exit 0