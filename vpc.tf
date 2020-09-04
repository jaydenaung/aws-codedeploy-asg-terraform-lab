##########################################
########### devops VPC  ##############
##########################################

# Create a VPC for the devops Server
resource "aws_vpc" "devops_vpc" {
  cidr_block           = var.devops_cidr_vpc
  enable_dns_hostnames = "true"

  tags = {
    Name = "DevOps_VPC"
  }
}

# Create an internet gateway to give internet access
resource "aws_internet_gateway" "devops_internet_gateway" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops_IGW"
  }
}

# A permissive security group
resource "aws_security_group" "devops_security_group" {
  vpc_id = aws_vpc.devops_vpc.id

  # Full inbound access
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops_SG"
  }
}
