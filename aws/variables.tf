###############################################################################
# VARIABLES 
###############################################################################

variable "region" {
  default = "eu-west-2" # London
}

variable "access_key" {}

variable "secret_key" {}

variable "key_name" {
  default = "morsley-io-rancher-k8s"
}

variable "keys_bucket" {
  default = "morsley-io-rancher"
}

variable "kube_config_filename" {
  default = "morsley-io-kube-config.yaml"
}

variable "instance_type" {
  default = "t2.xlarge"
}

variable "cluster_name" {
  default = "morsley-io"
}

# ToDo --> use throughout
variable "hostname" {
  default = "rancher.morsley.io"
}

variable "domain_name" {
  default = "morsley.io"
}