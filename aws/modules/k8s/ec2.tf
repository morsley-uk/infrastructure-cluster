#    ______ _____ ___  
#   |  ____/ ____|__ \ 
#   | |__ | |       ) |
#   |  __|| |      / / 
#   | |___| |____ / /_ 
#   |______\_____|____|
#                          

# ELASTIC CLOUD COMPUTE

# https://www.terraform.io/docs/providers/aws/r/instance.html

locals {
  bucket_name = "${replace(var.domain, ".", "-")}-${var.name}"
}

resource "aws_instance" "k8s" {

  # count = var.instance_count

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
    Name        = "${var.name}-ec2"
    Terraform   = "true"
    Environment = "Development"
  }

}

resource "aws_s3_bucket_object" "node-public-dns" {

  depends_on = [aws_s3_bucket.k8s]

  bucket  = local.bucket_name
  key     = "/${var.name}/node_public_dns.txt"
  content = aws_instance.k8s.public_dns
  content_type = "text/*"

}

output "ec2_k8s" {
  value = aws_instance.k8s
}