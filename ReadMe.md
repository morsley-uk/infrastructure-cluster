     _____                _   __  __      _ 
    |  __ \              | | |  \/  |    | |
    | |__) |___  __ _  __| | | \  / | ___| |
    |  _  // _ \/ _` |/ _` | | |\/| |/ _ \ |
    | | \ \  __/ (_| | (_| | | |  | |  __/_|
    |_|  \_\___|\__,_|\__,_| |_|  |_|\___(_)
             
The purpose of this project is to provision a Kubernetes cluster (via Rancher's
RKE - Rancher Kubernetes Engine) to host Rancher. This could have been hosted
on any Cloud provider, but I have chosen AWS (Amazon Web Services).

This is being achieved by using Terraform.     

Useful links:

## AWS:

https://www.terraform.io/docs/providers/aws/index.html

## Rancher (official):

https://www.terraform.io/docs/providers/rancher/index.html
https://www.terraform.io/docs/providers/rancher2/index.html

## Rancher RKE (unofficial):

RKE: https://github.com/rancher/terraform-provider-rke/releases

Because RKE hasn't yet been released to Terraform to maintain, it must be downloaded first:

Download from GitHub

Then add the file to your ~/.terraform.d/plugins/[Operating System] folder.
Replace the files OS portion with its version.

i.e. 

~/.terraform.d/plugins/linux_amd64/terraform-provider-rke_v1.0.0

(As I'm using Ubuntu 18.04 LTS)