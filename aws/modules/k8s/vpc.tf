#   __      _______   _____ 
#   \ \    / /  __ \ / ____|
#    \ \  / /| |__) | |     
#     \ \/ / |  ___/| |     
#      \  /  | |    | |____ 
#       \/   |_|     \_____|
#

# VIRTUAL PRIVATE CLOUD

resource "aws_vpc" "k8s-vpc" {

  cidr_block           = "10.0.0.0/16" # 65,536
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "k8s-vpc"
  }

}

# PUBLIC SUBNET

resource "aws_subnet" "public" {

  depends_on = [aws_vpc.k8s-vpc]

  vpc_id                  = aws_vpc.k8s-vpc.id
  cidr_block              = "10.0.1.0/24" # 256 - ToDo --> Variable
  map_public_ip_on_launch = true
  #availability_zone = ?

  tags = {
    Name = "k8s-public-subnet"
  }

}

# PRIVATE SUBNET

//resource "aws_subnet" "private" {
//
//  depends_on = [aws_vpc.k8s-vpc]
//
//  vpc_id     = aws_vpc.k8s-vpc.id
//  cidr_block = "10.0.2.0/24" # ToDo --> Variable
//  #map_public_ip_on_launch = true
//
//  tags = {
//    Name = "Private"
//  }
//
//}

# INTERNET GATEWAY

# 1 - An Internet Gateway must be attached to your VPC.
# 2 - All instances in your subnet must have either a public address or an Elastic IP address.
# 3 - Your subnet's route table must point to the Internet Gateway.
# 4 - All network access control and security group rules must be configured to allow the required traffic to and from 
#     your instance

# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html

resource "aws_internet_gateway" "k8s-igw" {

  depends_on = [
    aws_vpc.k8s-vpc,
    aws_subnet.public
  ]

  vpc_id = aws_vpc.k8s-vpc.id

  tags = {
    Name = "k8s-igw"
  }

}

# ROUTE TABLES

# https://www.terraform.io/docs/providers/aws/r/route_table.html

resource "aws_route_table" "k8s-rt" {

  vpc_id = aws_vpc.k8s-vpc.id

  route {
    cidr_block = "0.0.0.0/0" # ToDo --> Variable
    gateway_id = aws_internet_gateway.k8s-igw.id
  }

  tags = {
    Name = "k8s-rt"
  }

}

# https://www.terraform.io/docs/providers/aws/r/route_table_association.html

resource "aws_route_table_association" "k8s-rta" {

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.k8s-rt.id

}

# NAT GATEWAY

# https://www.terraform.io/docs/providers/aws/r/nat_gateway.html

//resource "aws_nat_gateway" "gw" {
//  
//  allocation_id = aws_eip.eip.id
//  subnet_id     = aws_subnet.public.id
//  
//}

# SECURITY GROUPS

# https://www.terraform.io/docs/providers/aws/r/security_group.html

resource "aws_security_group" "k8s-sg" {

  name        = "k8s-sg"
  description = "Kubernetes"
  vpc_id      = aws_vpc.k8s-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  //
  //  //  ingress {
  //  //    from_port   = 22
  //  //    to_port     = 22
  //  //    protocol    = "tcp"
  //  //    cidr_blocks = ["0.0.0.0/0"]
  //  //  }
  //  //
  //  //  ingress {
  //  //    from_port   = 6443
  //  //    to_port     = 6443
  //  //    protocol    = "tcp"
  //  //    cidr_blocks = ["0.0.0.0/0"]
  //  //  }
  //
  //  //    ingress {
  //  //        from_port   = 80
  //  //        to_port     = 80
  //  //        protocol    = "tcp"
  //  //        cidr_blocks = ["0.0.0.0/0"]
  //  //    }
  //
  //  //    ingress {
  //  //        from_port   = 443
  //  //        to_port     = 443
  //  //        protocol    = "tcp"
  //  //        cidr_blocks = ["0.0.0.0/0"]
  //  //    }
  //
  //  //    ingress {
  //  //        from_port   = 8080
  //  //        to_port     = 8080
  //  //        protocol    = "tcp"
  //  //        cidr_blocks = ["0.0.0.0/0"]
  //  //    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# NETWORK ACLs

# https://www.terraform.io/docs/providers/aws/r/network_acl.html

resource "aws_network_acl" "allow-all" {

  vpc_id = aws_vpc.k8s-vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "Allow All"
  }

}

# DHCP OPTIONS

# !

# ELASTIC IP 

# https://www.terraform.io/docs/providers/aws/r/eip.html

//resource "aws_eip" "eip" {
//  
//  //instance = "${aws_instance.web.id}"
//  vpc      = true
//
//  tags = {
//    Name = "Kubernetes"
//  }
//  
//}