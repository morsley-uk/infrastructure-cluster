# https://www.terraform.io/docs/providers/null/resource.html

resource "null_resource" "install-docker" {

  depends_on = [aws_instance.k8s]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  #provisioner "remote-exec" {
  #  script = "install_docker.sh"
  #}

  # https://www.terraform.io/docs/provisioners/file.html

  provisioner "file" {
    source      = "install_docker.sh"
    destination = "install_docker.sh"
  }

  # https://www.terraform.io/docs/provisioners/remote-exec.html

  provisioner "remote-exec" {
    inline = ["chmod +x install_docker.sh && sh install_docker.sh"]
  }

}

# https://www.terraform.io/docs/providers/null/resource.html

resource "null_resource" "is-docker-ready" {

  depends_on = [null_resource.install-docker]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  #provisioner "remote-exec" {
  #  script = "is_docker_ready.sh"
  #}

  # https://www.terraform.io/docs/provisioners/file.html

  provisioner "file" {
    source      = "is_docker_ready.sh"
    destination = "is_docker_ready.sh"
  }

  # https://www.terraform.io/docs/provisioners/remote-exec.html

  provisioner "remote-exec" {
    inline = ["chmod +x is_docker_ready.sh && bash is_docker_ready.sh"]
  }

}