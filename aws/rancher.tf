#######################################################################################################################
# RANCHER
#######################################################################################################################

resource "null_resource" "install-rancher" {

    depends_on = [ null_resource.is-cluster-ready ]

    connection {
        type        = "ssh"
        host        = aws_instance.k8s.public_ip
        user        = "ubuntu"
        private_key = join("", tls_private_key.private_key.*.private_key_pem)
    }

    provisioner "local-exec" {
        command = "chmod +x install_rancher.sh && bash install_rancher.sh"
    }

}

resource "null_resource" "is-rancher-ready" {

    depends_on = [ null_resource.install-rancher ]

    connection {
        type        = "ssh"
        host        = aws_instance.k8s.public_ip
        user        = "ubuntu"
        private_key = join("", tls_private_key.private_key.*.private_key_pem)
    }

    provisioner "local-exec" {
        command = "chmod +x is_rancher_ready.sh && bash is_rancher_ready.sh"
    }

}