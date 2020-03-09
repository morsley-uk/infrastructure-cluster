###############################################################################
# SSH KEYS
###############################################################################

# https://www.terraform.io/docs/providers/tls/r/private_key.html

resource "tls_private_key" "node_key" {

  algorithm = "RSA"

}

output "private_key" {

  value = tls_private_key.node_key

}

# 

resource "aws_key_pair" "key_pair" {

  key_name   = var.node_key_name
  public_key = tls_private_key.node_key.public_key_openssh

}

output "key_pair" {

  value = aws_key_pair.key_pair

}

#

resource "aws_s3_bucket_object" "public-keys" {

  bucket     = var.keys_bucket
  key        = "/${var.node_key_name}.pub"
  content    = join("", tls_private_key.node_key.*.public_key_openssh)
  depends_on = [aws_s3_bucket.keys]

}

resource "null_resource" "delete-public-node-key" {

  provisioner "local-exec" {
    command = "rm rke/${var.node_key_name}.pub --force || true"
  }

}

resource "local_file" "public-node-key" {

  depends_on = [null_resource.delete-public-node-key]

  filename = "rke/${var.node_key_name}.pub"
  content  = join("", tls_private_key.node_key.*.public_key_openssh)

}

resource "aws_s3_bucket_object" "private-keys" {

  bucket     = var.keys_bucket
  key        = "/${var.node_key_name}.pem"
  content    = join("", tls_private_key.node_key.*.private_key_pem)
  depends_on = [aws_s3_bucket.keys]

}

resource "null_resource" "delete-private-node-key" {

  provisioner "local-exec" {
    command = "rm rke/${var.node_key_name}.pem --force || true"
  }

}

resource "local_file" "private-node-key" {

  depends_on = [null_resource.delete-private-node-key]

  filename = "rke/${var.node_key_name}.pem"
  content  = join("", tls_private_key.node_key.*.private_key_pem)

}