#   __      __        _       _     _           
#   \ \    / /       (_)     | |   | |          
#    \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___ 
#     \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#      \  / (_| | |  | | (_| | |_) | |  __/\__ \
#       \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
#                                             

variable "region" {
  default = "eu-west-2" # London
}

variable "name" {}

variable "access_key" {}

variable "secret_key" {}

variable "key_name" {}

variable "keys_bucket" {}

variable "kube_config_filename" {}

variable "instance_type" {
  default = "t2.2xlarge" # 8 vCPUs, 32 GB RAM
}

variable "instance_name" {}

variable "cluster_name" {
  default = "morsley-io"
}

variable "hostname" {}

variable "domain_name" {
  default = "morsley.io"
}