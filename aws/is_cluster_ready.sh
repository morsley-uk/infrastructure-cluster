#!/bin/bash


bash header.sh "Is Cluster Ready?"

bash are_nodes_ready.sh

bash footer.sh "Is Cluster Ready?"

exit 0