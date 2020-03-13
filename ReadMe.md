  _____                _   __  __      _ 
 |  __ \              | | |  \/  |    | |
 | |__) |___  __ _  __| | | \  / | ___| |
 |  _  // _ \/ _` |/ _` | | |\/| |/ _ \ |
 | | \ \  __/ (_| | (_| | | |  | |  __/_|
 |_|  \_\___|\__,_|\__,_| |_|  |_|\___(_)
                                         
# Infrastructure - Kubernetes

A Kubernetes cluster on AWS via Terraform.

This is to be achieved using Rancher!

AWS:

https://www.terraform.io/docs/providers/aws/index.html

Rancher (official):

https://www.terraform.io/docs/providers/rancher/index.html
https://www.terraform.io/docs/providers/rancher2/index.html

Rancher (unofficial):

RKE: https://github.com/rancher/terraform-provider-rke/releases

Download from GitHub

Then add the file to your .terraform/plugins/[Operating System] folder.
Replace the files OS portion with its version.

## Installing Rancher with Helm

https://rancher.com/docs/rancher/v2.x/en/installation/k8s-install/

1. Add node(s) with Terraform via AWS provider.
2. Add cluster with Terraform via RKE provider.
3. Add Rancher to cluster with Terraform via Bash scripts (Null_Reference resource).

## Install Rancher on the Kubernetes cluster

1. Add Helm chart repository.
2. Create a Rancher namespace.
3. Install Cert-Manager (Let's Encrypt).
4. Install Rancher with Helm.

# SSH

