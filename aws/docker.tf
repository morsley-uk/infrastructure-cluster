#    _____             _
#   |  __ \           | |
#   | |  | | ___   ___| | _____ _ __
#   | |  | |/ _ \ / __| |/ / _ \ '__|
#   | |__| | (_) | (__|   <  __/ |
#   |_____/ \___/ \___|_|\_\___|_|
#

# https://www.terraform.io/docs/providers/null/resource.html

resource "null_resource" "install-docker" {

  depends_on = [aws_instance.k8s]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  # https://www.terraform.io/docs/provisioners/file.html

  provisioner "file" {
    source      = "scripts/install_docker.sh"
    destination = "install_docker.sh"
  }

  # https://www.terraform.io/docs/provisioners/remote-exec.html

  provisioner "remote-exec" {
    inline = ["chmod +x install_docker.sh && bash install_docker.sh"]
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

  # https://www.terraform.io/docs/provisioners/file.html

  provisioner "file" {
    source      = "scripts/is_docker_ready.sh"
    destination = "is_docker_ready.sh"
  }

  # https://www.terraform.io/docs/provisioners/remote-exec.html

  provisioner "remote-exec" {
    inline = ["chmod +x is_docker_ready.sh && bash is_docker_ready.sh"]
  }

}