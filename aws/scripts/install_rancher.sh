#!/usr/bin/env bash

#    _____           _        _ _   _____                  _               
#   |_   _|         | |      | | | |  __ \                | |              
#     | |  _ __  ___| |_ __ _| | | | |__) |__ _ _ __   ___| |__   ___ _ __ 
#     | | | '_ \/ __| __/ _` | | | |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#    _| |_| | | \__ \ || (_| | | | | | \ \ (_| | | | | (__| | | |  __/ |   
#   |_____|_| |_|___/\__\__,_|_|_| |_|  \_\__,_|_| |_|\___|_| |_|\___|_|   
#                                                                        
                                        
# Install Rancher via Helm

export KUBECONFIG=$(pwd)/generated/morsley-io-kube-config.yaml

#kubectl get nodes

# https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/helm-rancher/

# 1. Add the Helm chart repository...

helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

# 2. Create a namespace for Rancher...

kubectl create namespace cattle-system

# 3. Choose your SSL configuration...

# We are going to try 'Rancher Generated Certificates' first, but once this is working, we'll try 'Let's Encrypt'.

# --- Cert-Manager ---

# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/v0.13.1/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install cert-manager jetstack/cert-manager \
  --version v0.14.0 \
  --namespace cert-manager \
  --wait
  
# --- Cert-Manager ---

# 4. Install Rancher with Helm and the chosen certificate option

helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

helm repo update

helm install rancher rancher-stable/rancher \
  --version v2.3.5 \
  --namespace cattle-system \
  --set hostname=rancher.morsley.io \
  --set ingress.tls.source=letsEncrypt \
  --set letsEncrypt.email=letsencrypt@morsley.uk \
  --wait

# https://whynopadlock.com
# https://www.ssllabs.com/ssltest/