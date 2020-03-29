#!/bin/bash

#    _____        _____ _           _              _____                _      ___  
#   |_   _|      / ____| |         | |            |  __ \              | |    |__ \ 
#     | |  ___  | |    | |_   _ ___| |_ ___ _ __  | |__) |___  __ _  __| |_   _  ) |
#     | | / __| | |    | | | | / __| __/ _ \ '__| |  _  // _ \/ _` |/ _` | | | |/ / 
#    _| |_\__ \ | |____| | |_| \__ \ ||  __/ |    | | \ \  __/ (_| | (_| | |_| |_|  
#   |_____|___/  \_____|_|\__,_|___/\__\___|_|    |_|  \_\___|\__,_|\__,_|\__, (_)  
#                                                                         __/ |    
#                                                                        |___/     
                                                                       
echo '###############################################################################'
echo '# IS CLUSTER READY...'
echo '###############################################################################'

#set -x

export KUBECONFIG=$(pwd)/$(FOLDER)/kube_config.yaml

is_cluster_ready () {

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
        echo "Yes"
        return 1
    fi
    echo "No - $feedback"
    return 0

}

is_numeric () {
  
  if [ "$1" -eq "$1" ] 2>/dev/null; then
    return 1
  fi
  
  return 0
  
}

print_deployment_headers () {
       
  print_deployment_footer
  printf "|     Ready |  Expected | Available |\n"
  print_deployment_footer
  
  return 0
  
}

print_deployment_footer () {
       
  printf "+-----------+-----------+-----------+\n"
  
  return 0
  
}

print_divider () {
  
  echo "-------------------------------------------------------------------------------"
  
  return 0
  
}

are_deployments_ready () {
  
  deployments_json=$(kubectl get deployments --all-namespaces --output "json")
  number_of_deployments=$(jq '.items | length' <<< $deployments_json)
  
  #echo $deployments_json | jq .
  #exit 0
  
  #feedback="Number of Deployments: ${number_of_deployments} | "
  
  print_deployment_headers
  
  is_ready="Yes"
  
  for ((i = 0 ; i < number_of_deployments ; i++)); do
        
        deployment_json=$(jq --arg i ${i} '.items[$i|tonumber]' <<< $deployments_json)
        
        deployment_name=$(jq  -r '.metadata.name' <<< $deployment_json)
        
        ready=$(jq '.status.readyReplicas' <<< $deployment_json)
        if is_numeric $ready; then
          ready=0
        fi
        
        expected=$(jq '.spec.replicas' <<< $deployment_json)
        
        available=$(jq '.status.availableReplicas' <<< $deployment_json)
        if is_numeric $available; then
          available=0
        fi
                
        printf "| %9d | %9d | %9d | %s\n" $ready $expected $available $observed $deployment_name
      
      if [ $ready -ne $expected ]; then
        is_ready="No"  
      fi
      
    done
    
    print_deployment_headers
    
  echo "${is_ready}"
  
  if [ "$is_ready" == "Yes" ]; then
    return 1
  fi 
  
  return 0
  
}

echo "Current Context:"
print_divider
kubectl config current-context
print_divider

echo "Are node(s) up...?"

while true; do
    
    is_cluster_ready

    if [[ $? == 1 ]]; then
        break
    fi

    sleep 5

done

sleep 100

print_divider
echo "Nodes:"
print_divider
kubectl get nodes
print_divider

echo "Are deployments ready...?"

while true; do
    
    are_deployments_ready

    if [[ $? == 1 ]]; then
        break
    fi
    
    sleep 10

done

print_divider
echo "Deployments:"
print_divider
kubectl get deployments --all-namespaces
print_divider

echo "Pods:"
print_divider
kubectl get pods --all-namespaces
print_divider

echo "Services:"
print_divider
kubectl get services --all-namespaces
print_divider


#set +x

echo '###############################################################################'
echo '# CLUSTER READY'
echo '###############################################################################'

exit 0