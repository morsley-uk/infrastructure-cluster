###############################################################################
# VARIABLES 
###############################################################################

variable "region" {
  default = "eu-west-2" # London
  #default = "us-east-2" # Ohio
  #default = "us-east-1" # North Virginia
  #default = "eu-west-1" # Ireland
}

variable "access_key" {}

variable "secret_key" {}

variable "node_key_name" {
  default = "morsley-uk-k8s"
}

variable "keys_bucket" {
  default = "morsley-uk-k8s-keys"
}

variable "instance_type" {
  #default = "t2.micro"
  default = "t2.xlarge"
}

# See: https://github.com/rancher/install-docker

//variable "install_docker_url" {
//  default = "https://releases.rancher.com/install-docker/19.03.5.sh"
//}
//
//variable "install_rke_url" {
//  default = "https://github.com/rancher/rke/releases/tag/v1.0.4/rke_linux_amd64"
//}