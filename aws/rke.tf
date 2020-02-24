#######################################################################################################################
# RKE - RANCHER KUBERNETES ENGINE
#######################################################################################################################

provider "rke" {
  log = true
}

resource "rke_cluster" "cluster" {
  
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
    internal_address = aws_instance.k8s.private_ip # Private IP of EC2
    user = "ubuntu"
    ssh_key = tls_private_key.private_key.private_key_pem
    role = ["controlplane", "etcd", "worker"]
  }

}

resource "local_file" "kube_cluster_yaml" {
    filename = "./kube_config_cluster.yml"
    content  = rke_cluster.cluster.kube_config_yaml
}