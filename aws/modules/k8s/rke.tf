#    _____  _  ________ 
#   |  __ \| |/ /  ____|
#   | |__) | ' /| |__   
#   |  _  /|  < |  __|  
#   | | \ \| . \| |____ 
#   |_|  \_\_|\_\______|
#

# RANCHER KUBERNETES ENGINE

resource "rke_cluster" "cluster" {

  depends_on = [null_resource.is-docker-ready]

  cluster_name = var.cluster_name

  disable_port_check = false

  ignore_docker_version = true

  nodes {
    address = aws_instance.k8s.public_ip
    internal_address = aws_instance.k8s.private_ip
    user    = "ubuntu"
    ssh_key = tls_private_key.node_key.private_key_pem
    role    = ["controlplane", "etcd", "worker"]
  }
  
  cloud_provider {
    name = "aws"
  }
  
}

resource "aws_s3_bucket_object" "kube-config-yaml" {

  depends_on = [aws_s3_bucket.k8s]

  bucket  = local.bucket_name
  key     = "/${var.name}/kube_config.yaml"
  content = rke_cluster.cluster.kube_config_yaml
  content_type = "text/*"

}

resource "local_file" "kube-config-yaml" {

  filename = "${path.cwd}/${var.name}/kube_config.yaml"
  content  = rke_cluster.cluster.kube_config_yaml

}

# https://www.terraform.io/docs/providers/null/resource.html

resource "null_resource" "is-cluster-ready" {

  depends_on = [
    rke_cluster.cluster,
    local_file.kube-config-yaml
  ]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    command = "chmod +x ${path.cwd}/modules/scripts/is_cluster_ready.sh && bash ${path.cwd}/modules/scripts/is_cluster_ready.sh"
    environment = {
      FOLDER = "${var.name}"
    }
  }

}

resource "null_resource" "destroy-cluster" {

  depends_on = [
    rke_cluster.cluster,
    local_file.kube-config-yaml,
    null_resource.is-cluster-ready
  ]

  # https://www.terraform.io/docs/provisioners/local-exec.html

  provisioner "local-exec" {
    when    = destroy
    command = "chmod +x ${path.cwd}/modules/scripts/destroy_cluster.sh && bash ${path.cwd}/modules/scripts/destroy_cluster.sh"
    environment = {
      FOLDER = "${var.name}"
    }
  }

}