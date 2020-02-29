# https://www.terraform.io/docs/providers/null/resource.html

resource "null_resource" "install-nginx" {

  depends_on = [aws_instance.k8s]

  connection {
    type        = "ssh"
    host        = aws_instance.k8s.public_ip
    user        = "ubuntu"
    private_key = join("", tls_private_key.node_key.*.private_key_pem)
  }

  # https://www.terraform.io/docs/provisioners/file.html

  provisioner "file" {
    source      = "install_nginx.sh"
    destination = "install_nginx.sh"
  }

  # https://www.terraform.io/docs/provisioners/local-exec.html

  #provisioner "local-exec" {
  #  command = "chmod +x install_nginx.sh && sh install_nginx.sh"
  #}

  # https://www.terraform.io/docs/provisioners/remote-exec.html

  //  provisioner "remote-exec" {
  //    script = "install_nginx.sh"
  //  }

  //  provisioner "remote-exec" {
  //    inline = [ "whoami" ]
  //  }

  provisioner "remote-exec" {
    inline = [ "chmod +x install_nginx.sh && sh install_nginx.sh" ]
  }

}