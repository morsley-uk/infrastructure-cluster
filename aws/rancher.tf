#    _____                  _               
#   |  __ \                | |              
#   | |__) |__ _ _ __   ___| |__   ___ _ __ 
#   |  _  // _` | '_ \ / __| '_ \ / _ \ '__|
#   | | \ \ (_| | | | | (__| | | |  __/ |   
#   |_|  \_\__,_|_| |_|\___|_| |_|\___|_|   
#                                         

module "k8s" {

  name = "rancher"

  access_key = var.access_key
  secret_key = var.secret_key

  region = var.region

  keys_bucket  = var.keys_bucket
  cluster_size = 1
  hostname     = "rancher.morsley.io"

  domain_name = "morsley.io"

  cluster_name = "morsley-io"

  source = "./modules/k8s"

}

output "rancher-public-dns" {

  value = module.k8s.public-dns

}

output "rancher-ssh-command" {

  value = module.k8s.ssh-command

}

//resource "null_resource" "install-rancher" {
//
//  depends_on = [
//    local_file.kube-config-yaml,
//    null_resource.is-cluster-ready
//  ]
//
//  connection {
//    type        = "ssh"
//    host        = aws_instance.k8s.public_ip
//    user        = "ubuntu"
//    private_key = join("", tls_private_key.node_key.*.private_key_pem)
//  }
//
//  # https://www.terraform.io/docs/provisioners/local-exec.html
//
//  provisioner "local-exec" {
//    command = "chmod +x scripts/install_rancher.sh && bash scripts/install_rancher.sh"
//  }
//  
//}