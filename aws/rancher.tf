#######################################################################################################################
# RANCHER
#######################################################################################################################

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

  depends_on = [null_resource.is-cluster-ready]

  metadata {
    name = "cert-manager"
  }

}

# Get the JetStack Helm repository...

data "helm_repository" "jetstack" {

  depends_on = [kubernetes_namespace.cert-manager]

  name = "jetstack"
  url  = "https://charts.jetstack.io"

}

# Install the JetPack Helm repository...

resource "helm_release" "cert-manager" {

  depends_on = [
    kubernetes_namespace.cert-manager,
    data.helm_repository.jetstack
  ]

  name       = "cert-manager"
  repository = data.helm_repository.jetstack.metadata[0].name
  chart      = "jetstack/cert-manager"

}

# kubectl get-pods --namespace cert-manager

resource "null_resource" "is-cert-manager-ready" {

  depends_on = [helm_release.cert-manager]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  provisioner "local-exec" {
    command = "chmod +x scripts/is_cert_manager_ready.sh && bash scripts/is_cert_manager_ready.sh"
  }

}

# -------
# Rancher
# -------

resource "kubernetes_namespace" "rancher" {

  depends_on = [null_resource.is-cert-manager-ready]

  metadata {
    name = "rancher"
  }

}

# Get the Rancher Helm repository...

data "helm_repository" "rancher" {

  depends_on = [kubernetes_namespace.rancher]

  name = "rancher-stable"
  url  = "https://releases.rancher.com/server-charts/stable"

}

# Install the JetPack Helm repository...

resource "helm_release" "rancher" {

  depends_on = [
    kubernetes_namespace.rancher,
    data.helm_repository.rancher
  ]

  name       = "rancher-stable"
  repository = data.helm_repository.rancher.metadata[0].name
  chart      = "rancher-stable/rancher"

  set {
    name  = "addLocal"
    value = "true"
  }

  set {
    name  = "hostname"
    value = aws_instance.k8s.public_dns
  }

}

resource "null_resource" "install-rancher" {

  depends_on = [helm_release.rancher]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  provisioner "local-exec" {
    command = "chmod +x scripts/is_rancher_ready.sh && bash scripts/is_rancher_ready.sh"
  }

}

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