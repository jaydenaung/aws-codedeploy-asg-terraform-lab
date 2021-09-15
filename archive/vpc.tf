##########################################
########### devops VPC  ##############
##########################################

# Devops VPC
resource "aws_vpc" "devops_vpc" {
  cidr_block           = var.devops_cidr_vpc
  enable_dns_hostnames = "true"

  tags = {
    Name = "DevOps_VPC"
  }
}

resource "aws_internet_gateway" "devops_internet_gateway" {
  vpc_id = aws_vpc.devops_vpc.id

  tags = {
    Name = "devops_IGW"
  }
}

resource "aws_security_group" "devops_security_group" {
  vpc_id = aws_vpc.devops_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

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
