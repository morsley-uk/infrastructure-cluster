###############################################################################
# VARIABLES 
###############################################################################

variable "region" {
  default = "eu-west-2" # London
}

variable "access_key" {}

variable "secret_key" {}

variable "key_name" {
  default = "morsley-uk-k8s"
}

variable "keys_bucket" {
  default = "morsley-uk-k8s-keys"
}

variable "instance_type" {
  default = "t2.medium"
}

# See: https://github.com/rancher/install-docker

variable "docker_install_url" {
  default = "https://releases.rancher.com/install-docker/19.03.5.sh"
}

variable "rke_install_url" {
  default = "https://github.com/rancher/rke/releases/tag/v1.0.4/rke_linux_amd64"
}