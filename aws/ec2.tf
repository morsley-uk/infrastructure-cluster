###############################################################################
# EC2 - Elastic Compute Cloud
###############################################################################

# https://www.terraform.io/docs/providers/template/index.html

#data "template_file" "ec2-user-data" {

#  template = file("${path.module}/ec2_user_data.sh")

#  vars = {
#    install_docker_url = var.install_docker_url
#  }

#}

#output "ec2_user_data_sh" {

#  value = data.template_file.ec2-user-data.rendered

#}

# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "aws_instance" "k8s" {

  depends_on = [
    aws_security_group.k8s-sg
  ]

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.k8s-sg.id]
  #iam_instance_profile   = aws_iam_instance_profile.rke.name

  tags = {
    Name        = "k8s-ec2"
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Kubernetes Cluster"
  }

}

output "ec2_k8s" {
  value = aws_instance.k8s
}