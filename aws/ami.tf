#             __  __ _____ 
#       /\   |  \/  |_   _|
#      /  \  | \  / | | |  
#     / /\ \ | |\/| | | |  
#    / ____ \| |  | |_| |_ 
#   /_/    \_\_|  |_|_____|
#                        

# AMAZON MACHINE IMAGE

# https://cloud-images.ubuntu.com/locator/ec2/

data "aws_ami" "ubuntu" {

  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}