#    _____                  _               
#   |  __ \                | |              
#   | |__) |__ _ _ __   ___| |__   ___ _ __ 
#   |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#   | | \ \ (_| | | | | (__| | | |  __/ |   
#   |_|  \_\__,_|_| |_|\___|_| |_|\___|_|   
#    _  __     _                          _            
#   | |/ /    | |                        | |           
#   | ' /_   _| |__   ___ _ __ _ __   ___| |_ ___  ___ 
#   |  <| | | | '_ \ / _ \ '__| '_ \ / _ \ __/ _ \/ __|
#   | . \ |_| | |_) |  __/ |  | | | |  __/ ||  __/\__ \
#   |_|\_\__,_|_.__/ \___|_|  |_| |_|\___|\__\___||___/
#      

module "k8s" {

  name = "rancher"

  access_key = var.access_key
  secret_key = var.secret_key

  region = var.region

  bucket_name  = var.bucket_name
  cluster_size = 1
  domain_name  = "morsley.io"
  hostname     = "rancher.morsley.io"
  
  cluster_name = "morsley-io"

  source = "./modules/k8s"

}

output "rancher-public-dns" {

  value = module.k8s.public-dns

}

output "rancher-ssh-command" {

  value = module.k8s.ssh-command

}