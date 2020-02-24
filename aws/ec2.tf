###############################################################################
# EC2 - Elastic Compute Cloud
###############################################################################

# https://www.terraform.io/docs/providers/aws/r/instance.html

resource "aws_instance" "concourse" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.medium"
  subnet_id              = sort(data.aws_subnet_ids.subnets.ids)[0]
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = true
  vpc_security_group_ids = data.aws_security_groups.security-groups.ids

  tags = {
    Name        = "Kubernetes"
    Terraform   = "true"
    Environment = "Development"
    Operation   = "Kubernetes"
  }

}