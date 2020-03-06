#######################################################################################################################
# RANCHER
#######################################################################################################################

resource "null_resource" "kube-config" {

  depends_on = [ null_resource.is-cluster-ready ]
   
  provisioner "file" {
    source = "rancher/kube_config.yaml"
    destination = "~/.kube/config"
  }
  
} 

provider "kubernetes" {
  
  load_config_file = true
  
}

# -----------------------
# Cert-Manager - JetStack
# -----------------------

# Jetstack - Kubernetes --> https://cert-manager.io/docs/installation/kubernetes

# Create namespace for cert manager...

# https://terraform.io/docs/providers/kubernetes/index.html

resource "kubernetes_namespace" "cert-manager" {

  depends_on = [ null_resource.kube-config ]
  
  metadata {
    name = "cert-manager"
  }

}

# Get the JetStack Helm repository...

data "helm_repository" "jetstack" {
  
  depends_on = [ kubernetes_namespace.cert-manager ]
  
  name = "jetstack"
  url = "https://charts.jetstack.io"
  
}

# Install the JetPack Helm repository...

resource "helm_release" "cert-manager" {
  
  depends_on = [ kubernetes_namespace.cert-manager ]
  
  name = "cert-manager"
  repository = data.helm_repository.jetstack.metadata[0].name
  chart = "jetstack/cert-manager"
  
}

# kubectl get-pods --namespace cert-manager

//resource "null_resource" "is-cert-manager-ready" {
//
//    depends_on = [ helm_release.cert-manager ]
//
//    connection {
//        type        = "ssh"
//        host        = aws_instance.k8s.public_ip
//        user        = "ubuntu"
//        private_key = join("", tls_private_key.node_key.*.private_key_pem)
//    }
//
//    provisioner "local-exec" {
//        command = "chmod +x is_cert_manager_ready.sh && bash is_cert_manager_ready.sh"
//    }
//  
//}

# -------
# Rancher
# -------

//resource "null_resource" "install-rancher" {
//
//    depends_on = [ null_resource.is-cluster-ready ]
//
//    connection {
//        type        = "ssh"
//        host        = aws_instance.k8s.public_ip
//        user        = "ubuntu"
//        private_key = join("", tls_private_key.private_key.*.private_key_pem)
//    }
//
//    provisioner "local-exec" {
//        command = "chmod +x install_rancher.sh && bash install_rancher.sh"
//    }
//
//}
//
//resource "null_resource" "is-rancher-ready" {
//
//    depends_on = [ null_resource.install-rancher ]
//
//    connection {
//        type        = "ssh"
//        host        = aws_instance.k8s.public_ip
//        user        = "ubuntu"
//        private_key = join("", tls_private_key.private_key.*.private_key_pem)
//    }
//
//    provisioner "local-exec" {
//        command = "chmod +x is_rancher_ready.sh && bash is_rancher_ready.sh"
//    }
//
//}