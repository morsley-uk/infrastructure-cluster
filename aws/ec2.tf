###############################################################################
# EC2 - Elastic Compute Cloud
###############################################################################

# https://www.terraform.io/docs/providers/template/index.html

data "template_file" "ec2-user-data" {

  template = file("${path.module}/ec2_user_data.sh")

  vars = {
    docker_install_url = var.docker_install_url
  }

}

# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "aws_instance" "k8s" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.k8s-sg.id]

  user_data = data.template_file.ec2-user-data.rendered

  //  connection {
  //    type        = "ssh"
  //    host        = self.public_ip
  //    user        = "ubuntu"
  //    private_key = join("", tls_private_key.private_key.*.private_key_pem)
  //  }
  //
  //  provisioner "remote-exec" {
  //    inline = [
  //      "sudo apt-get --quiet update",
  //      "sudo rm /boot/grub/menu.lst ",
  //      "sudo update-grub-legacy-ec2 -y",
  //      "sudo apt-get --quite upgrade -y",
  //      "sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y",
  //      "sudo curl -fsSL https://get.docker.com -o get-docker.sh",
  //      "sudo chmod +x get-docker.sh",
  //      "./get-docker.sh",
  //      "sudo usermod -aG docker ubuntu"
  //    ]
  //  }

  tags = {
    Name        = "Kubernetes"
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Kubernetes"
  }

}