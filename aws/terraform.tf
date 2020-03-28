#     _______                   __
#   |__   __|                 / _|
#      | | ___ _ __ _ __ __ _| |_ ___  _ __ _ __ ___
#      | |/ _ \ '__| '__/ _` |  _/ _ \| '__| '_ ` _ \
#      | |  __/ |  | | | (_| | || (_) | |  | | | | | |
#      |_|\___|_|  |_|  \__,_|_| \___/|_|  |_| |_| |_|
#

terraform {

  required_version = "= 0.12.24" # https://github.com/hashicorp/terraform/releases

  required_providers {
    aws = {
      version = "= 2.55.0" # https://registry.terraform.io/providers/hashicorp/aws/
    }
  }

  backend "s3" {
    bucket         = "morsley-io-terraform"
    key            = "infrastructure-k8s"
    region         = "eu-west-2"
    dynamodb_table = "morsley-io-tfstatelock-k8s"
    encrypt        = true
  }

}