#   __      __        _       _     _           
#   \ \    / /       (_)     | |   | |          
#    \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___ 
#     \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#      \  / (_| | |  | | (_| | |_) | |  __/\__ \
#       \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
#                                             

variable "region" {}

variable "name" {}

variable "access_key" {}
variable "secret_key" {}

variable "keys_bucket" {}

variable "instance_type" {
  default = "t2.2xlarge" # 8 vCPUs, 32 GB RAM
}

variable "cluster_size" {
  default = 1
}

variable "cluster_name" {}

variable "hostname" {}

variable "domain_name" {}