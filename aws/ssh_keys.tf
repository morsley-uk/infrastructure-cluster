#     _____ _____ _    _   _  __              
#    / ____/ ____| |  | | | |/ /              
#   | (___| (___ | |__| | | ' / ___ _   _ ___ 
#    \___ \\___ \|  __  | |  < / _ \ | | / __|
#    ____) |___) | |  | | | . \  __/ |_| \__ \
#   |_____/_____/|_|  |_| |_|\_\___|\__, |___/
#                                    __/ |    
#                                   |___/     

# https://www.terraform.io/docs/providers/tls/r/private_key.html

resource "tls_private_key" "node_key" {

  algorithm = "RSA"

}

output "private_key" {

  value = tls_private_key.node_key

}

# 

resource "aws_key_pair" "key_pair" {

  key_name   = var.key_name
  public_key = tls_private_key.node_key.public_key_openssh

}

output "key_pair" {

  value = aws_key_pair.key_pair

}

#

resource "aws_s3_bucket_object" "public-key" {

  bucket     = var.keys_bucket
  key        = "/${var.key_name}.pub"
  content    = join("", tls_private_key.node_key.*.public_key_openssh)
  depends_on = [aws_s3_bucket.k8s]

}

resource "null_resource" "delete-public-key" {

  provisioner "local-exec" {
    command = "rm generated/${var.key_name}.pub --force || true"
  }

}

resource "local_file" "public-key" {

  depends_on = [null_resource.delete-public-key]

  filename = "generated/${var.key_name}.pub"
  content  = join("", tls_private_key.node_key.*.public_key_openssh)

}

resource "aws_s3_bucket_object" "private-key" {

  bucket     = var.keys_bucket
  key        = "/${var.key_name}.pem"
  content    = join("", tls_private_key.node_key.*.private_key_pem)
  depends_on = [aws_s3_bucket.k8s]

}

resource "null_resource" "delete-private-key" {

  provisioner "local-exec" {
    command = "rm generated/${var.key_name}.pem --force || true"
  }

}

resource "local_file" "private-key" {

  depends_on = [null_resource.delete-private-key]

  filename = "generated/${var.key_name}.pem"
  content  = join("", tls_private_key.node_key.*.private_key_pem)

}