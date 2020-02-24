#######################################################################################################################
# VPC - Virtual Private Cloud
#######################################################################################################################

resource "aws_default_vpc" "default" {

    tags = {
        Name = "Default VPC"
    }

}

# output "default_vpc_id" {

#     value = aws_default_vpc.default

# }

# SUBNETS...

data "aws_subnet_ids" "subnets" {

    vpc_id = aws_default_vpc.default.id

}

# output "subnet_ids" {

#     value = data.aws_subnet_ids.subnets

# }

# output "first_subnet_id" {

#     value = sort(data.aws_subnet_ids.subnets.ids)[0]

# }

# SECURITY GROUPS...

data "aws_security_groups" "security-groups" {

    filter {

        name = "vpc-id"
        values = [aws_default_vpc.default.id]

    }

}

# output "security_groups" {

#     value = data.aws_security_groups.security-groups

# }

# output "security_group_ids" {

#     value = data.aws_security_groups.security-groups.ids

# }