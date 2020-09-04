

resource "aws_subnet" "devops-pub-2a" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.40.0.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "devops_public_subnet_2a"
  }
}

resource "aws_subnet" "devops-prv-2a" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.40.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "devops_private_subnet_2a"
  }
}

resource "aws_subnet" "devops-pub-2b" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.40.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "devops_public_subnet_2b"
  }
}

resource "aws_subnet" "devops-prv-2b" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.40.3.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "devops_private_subnet_2b"
  }
}

resource "aws_subnet" "devops-pub-2c" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.40.4.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "devops_public_subnet_2c"
  }
}

resource "aws_subnet" "devops-prv-2c" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.40.5.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "devops_private_subnet_2c"
  }
}

