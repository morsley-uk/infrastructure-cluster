#    _____          __  __ 
#   |_   _|   /\   |  \/  |
#     | |    /  \  | \  / |
#     | |   / /\ \ | |\/| |
#    _| |_ / ____ \| |  | |
#   |_____/_/    \_\_|  |_|
#

# IDENTITY & ACCESS MANAGEMENT

resource "aws_iam_role" "rke-role" {

  name = "rke-role"

  assume_role_policy = file("${path.module}/rke-role.json")

}

resource "aws_iam_role_policy" "rke-access-policy" {

  name = "rke-access-policy"
  role = aws_iam_role.rke-role.id

  policy = file("${path.module}/rke-policy.json")

}

resource "aws_iam_instance_profile" "rke" {

  name = "RKE"
  role = aws_iam_role.rke-role.name

  lifecycle {
    create_before_destroy = true
  }

}