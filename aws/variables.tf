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

variable "public_keys_bucket" {
  default = "morsley-uk-k8s-public-keys"
}

variable "private_keys_bucket" {
  default = "morsley-uk-k8s-private-keys"
}