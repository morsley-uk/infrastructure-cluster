###############################################################################
# SSH KEYS
###############################################################################

# https://www.terraform.io/docs/providers/tls/r/private_key.html

resource "tls_private_key" "private_key" {

  algorithm = "RSA"

}

output "private_key" {

  value = tls_private_key.private_key

}

# 

resource "aws_key_pair" "key_pair" {

  key_name   = var.key_name
  public_key = tls_private_key.private_key.public_key_openssh

}

output "key_pair" {

  value = aws_key_pair.key_pair

}

#

resource "aws_s3_bucket_object" "public_keys" {
  bucket     = var.keys_bucket
  key        = "/${var.key_name}.pub"
  content    = join("", tls_private_key.private_key.*.public_key_openssh)
  depends_on = [aws_s3_bucket.keys]
}

resource "aws_s3_bucket_object" "private_keys" {
  bucket     = var.keys_bucket
  key        = "/${var.key_name}.pem"
  content    = join("", tls_private_key.private_key.*.private_key_pem)
  depends_on = [aws_s3_bucket.keys]
}