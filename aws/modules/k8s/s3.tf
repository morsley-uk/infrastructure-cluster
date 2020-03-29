#     _____ ____  
#    / ____|___ \ 
#   | (___   __) |
#    \___ \ |__ < 
#    ____) |___) |
#   |_____/|____/ 
#               

# SIMPLE STORAGE SERVICE

locals {
  bucket_name = "${replace(var.domain, ".", "-")}-${var.name}"
}

resource "aws_s3_bucket" "k8s" {

  bucket = local.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  force_destroy = true

}