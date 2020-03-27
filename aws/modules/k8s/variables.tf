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

variable "bucket_name" {}

variable "instance_type" {
  #default = "t2.medium" # 2 vCPUs, 4 GB RAM
  #default = "t2.large" # 2 vCPUs, 8 GB RAM
  #default = "t2.xlarge" # 4 vCPUs, 16 GB RAM
  default = "t2.2xlarge" # 8 vCPUs, 32 GB RAM
}

variable "cluster_size" {
  default = 1
}

variable "cluster_name" {}

variable "hostname" {}

variable "domain_name" {}