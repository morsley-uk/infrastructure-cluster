resource "null_resource" "install-docker" {

  depends_on = [aws_instance.k8s]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.private_key.*.private_key_pem)
  }

  provisioner "remote-exec" {
    script = "install_docker.sh"
  }

}

resource "null_resource" "is-docker-ready" {

  depends_on = [null_resource.install-docker]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.private_key.*.private_key_pem)
  }

  provisioner "remote-exec" {
    script = "is_docker_ready.sh"
  }

}