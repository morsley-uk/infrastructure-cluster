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

  # count = var.instance_count

  depends_on = [
    aws_security_group.k8s-sg,
    aws_internet_gateway.k8s-igw
  ]

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone      = var.availability_zone 
  subnet_id              = aws_subnet.public.id
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.k8s-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.rke.name

  tags = {
    Name                  = "${var.name}-ec2"
    "${local.cluster_id}" = "owned" # Required by Rancher RKE
    Terraform             = "true"
  }
  
}

resource "aws_s3_bucket_object" "node-public-dns" {

  depends_on = [aws_s3_bucket.k8s]

  bucket  = local.bucket_name
  key     = "/${var.name}/node_public_dns.txt"
  content = aws_instance.k8s.public_dns
  content_type = "text/*"

}

resource "aws_s3_bucket_object" "node-public-ip" {

  depends_on = [aws_s3_bucket.k8s]

  bucket  = local.bucket_name
  key     = "/${var.name}/node_public_ip.txt"
  content = aws_instance.k8s.public_ip
  content_type = "text/*"

}

output "ec2_k8s" {
  value = aws_instance.k8s
}