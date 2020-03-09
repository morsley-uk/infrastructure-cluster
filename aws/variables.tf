###############################################################################
# VARIABLES 
###############################################################################

variable "region" {
  default = "eu-west-2" # London
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