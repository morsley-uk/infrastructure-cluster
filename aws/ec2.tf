#    ______ _____ ___  
#   |  ____/ ____|__ \ 
#   | |__ | |       ) |
#   |  __|| |      / / 
#   | |___| |____ / /_ 
#   |______\_____|____|
#                          

# ELASTIC CLOUD COMPUTE

# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "aws_instance" "k8s" {

  depends_on = [
    aws_security_group.k8s-sg,
    aws_internet_gateway.k8s-igw
  ]

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.k8s-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.rke.name

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