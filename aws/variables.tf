###############################################################################
# VARIABLES 
###############################################################################

variable "region" {
  default = "eu-west-2" # London
}

variable "access_key" {}

variable "secret_key" {}

variable "node_key_name" {
  default = "morsley-uk-k8s" # ToDo --> replace morsley.uk with morsley.io
}

# ToDo --> rename to rancher_bucket_name
variable "keys_bucket" {
  default = "morsley-uk-rancher" # ToDo --> replace morsley.uk with morsley.io
}

# ToDo --> use throughout
variable "kube_config_filename" {
  default = "kube-config.yaml"
}

variable "instance_type" {
  #default = "t2.micro"
  default = "t2.xlarge"
}

# ToDo --> use throughout
variable "cluster_name" {
  default = "morsley-io"
}

# ToDo --> use throughout
variable "hostname" {
  default = "rancher.morsley.io"
}