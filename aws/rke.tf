#######################################################################################################################
# RKE - RANCHER KUBERNETES ENGINE
#######################################################################################################################

# data "template_file" "rke-cluster-yaml" {

#   template = file("${path.module}/")

#   vars = {
#     docker_install_url = var.docker_install_url
#   }

# }

# output "ec2_user_data_sh" {

#   value = data.template_file.ec2-user-data.rendered

# }


# resource "null_resource" "install-rke" {

#     depends_on = [ null_resource.is-docker-running ]

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


provider "rke" {
  log = true
}

resource "rke_cluster" "cluster" {

  depends_on = [null_resource.is-docker-ready]

  disable_port_check = false

  cluster_name = "morsley-uk"

  cloud_provider {
    name = "aws"
  }

  services {
    kube_api {
      audit_log {
        enabled = true
      }
      secrets_encryption_config {
        enabled = true
      }
      
    }
  }

  nodes {
    address = aws_instance.k8s.public_ip # Public IP of EC2
    #address = aws_instance.k8s.public_dns # Public DNS of EC2
    #internal_address = aws_instance.k8s.private_ip # Private IP of EC2
    #internal_address = aws_instance.k8s.private_dns # Private DNS of EC2
    user             = "ubuntu"
    ssh_key          = tls_private_key.private_key.private_key_pem
    #ssh_key = join("", tls_private_key.private_key.*.private_key_pem)
    #ssh_key = tls_private_key.private_key.*.private_key_pem
    #ssh_key = file()
    role = ["controlplane", "etcd", "worker"]
  }

}



#resource "local_file" "kube_cluster_yaml" {
#    filename = "./kube_config_cluster.yml"
#    content  = rke_cluster.cluster.kube_config_yaml
#}
