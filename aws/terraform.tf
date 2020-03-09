###############################################################################
# TERRAFORM
###############################################################################

terraform {

  required_version = "= 0.12.23"

  backend "s3" {
    bucket         = "morsley-io-terraform"
    key            = "infrastructure"
    region         = "eu-west-2"
    dynamodb_table = "tfstatelock-rancher-k8s"
    encypt         = true
  }

}