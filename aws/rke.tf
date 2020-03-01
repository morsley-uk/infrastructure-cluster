#######################################################################################################################
# RKE - RANCHER KUBERNETES ENGINE
#######################################################################################################################

# resource "null_resource" "install-rke" {

#     depends_on = [ null_resource.is-docker-ready ]

#     connection {
#         type        = "ssh"
#         host        = aws_instance.k8s.public_ip
#         user        = "ubuntu"
#         private_key = join("", tls_private_key.private_key.*.private_key_pem)
#     }

#     provisioner "remote-exec" {
#         script = "install_rke.sh"
#     }

# }

# resource "null_resource" "is-docker-running" {

#     depends_on = [ null_resource.install-docker ]

#     connection {
#         type        = "ssh"
#         host        = aws_instance.k8s.public_ip
#         user        = "ubuntu"
#         private_key = join("", tls_private_key.private_key.*.private_key_pem)
#     }

#     provisioner "remote-exec" {
#         script = "is_docker_running.sh"
#     } 

# }


//provider "rke" {
//  name = "aws"
//}

resource "rke_cluster" "cluster" {

  depends_on = [null_resource.is-docker-ready]

  cluster_name = "morsley-uk"
  
  disable_port_check = false

  ignore_docker_version = true
  
//  cloud_provider {
//    name = "aws"
//  }

//  services {
//    kube_api {
//      audit_log {
//        enabled = true
//      }
//      secrets_encryption_config {
//        enabled = true
//      }
//    }
//  }

//  network {
//    plugin = "canal"
//  }
  
  nodes {
    address = aws_instance.k8s.public_ip # Public IP of EC2
    #internal_address = aws_instance.k8s.private_ip # Private IP of EC2
    user    = "ubuntu"
    ssh_key = tls_private_key.node_key.private_key_pem
    role = [ "controlplane","etcd","worker" ]
  }
  
}

resource "local_file" "kube_cluster_yaml" {
   filename = "./kube_config_cluster.yml"
   content  = rke_cluster.cluster.kube_config_yaml
}