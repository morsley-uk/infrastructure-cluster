#######################################################################################################################
# RKE - RANCHER KUBERNETES ENGINE
#######################################################################################################################

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
    role    = ["controlplane", "etcd", "worker"]
  }

}

resource "local_file" "kube_cluster_yaml" {

  filename = "${path.cwd}/rancher/kube_config.yaml"
  content  = rke_cluster.cluster.kube_config_yaml

  provisioner "local-exec" {
    command = "chmod +x scripts/copy_kube_config.sh && bash scripts/copy_kube_config.sh"
  }

}

# https://www.terraform.io/docs/providers/null/resource.html

resource "null_resource" "is-cluster-ready" {

  depends_on = [rke_cluster.cluster]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "chmod +x scripts/is_cluster_ready.sh && bash scripts/is_cluster_ready.sh"
  }

}

resource "null_resource" "destroy-cluster" {

  depends_on = [local_file.kube_cluster_yaml]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    when    = destroy
    command = "chmod +x scripts/destroy_cluster.sh && bash scripts/destroy_cluster.sh"
  }

}