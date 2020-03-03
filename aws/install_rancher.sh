#!/bin/sh

echo '###############################################################################'
echo '# INSTALLING RANCHER...'
echo '###############################################################################'

export KUBECONFIG=$(pwd)/kube_config.yaml

# Please refer to the following article:
# Installing Rancher on a Kubernetes Cluster --> https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/

# Steps required to install Rancher:
# 1. Add Helm chart repository
# 2. Create a Namespace for Rancher
# 3. Install Cert-Manager
# 4. Install Rancher

# -----------------------------
# Add the Helm Chart Repository
# -----------------------------

helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

# ------------------------------
# Create a Namespace for Rancher
# ------------------------------

kubectl create namespace rancher

# --------------------
# Install cert-manager
# --------------------

# Important: Use Helm v2.12.1 or higher

kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.12/deploy/manifests/00-crds.yaml

> **Important:**
> If you are running Kubernetes v1.15 or below, you will need to add the `--validate=false flag to your kubectl apply command above else you will receive a validation error relating to the x-kubernetes-preserve-unknown-fields field in cert-manager’s CustomResourceDefinition resources. This is a benign error and occurs due to the way kubectl performs resource validation.

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.12.0

# ---------------
# Install Rancher
# ---------------



echo '###############################################################################'
echo '# RANCHER INSTALLED'
echo '###############################################################################'

return 0