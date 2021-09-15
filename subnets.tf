
resource "aws_subnet" "devops-pub-1a" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.44.0.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "devops_public_subnet_1a"
  }
}

resource "aws_subnet" "devops-prv-1a" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.44.1.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "devops_private_subnet_1a"
  }
}

resource "aws_subnet" "devops-pub-1b" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.44.2.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "devops_public_subnet_1b"
  }
}

resource "aws_subnet" "devops-prv-1b" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.44.3.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "devops_private_subnet_1b"
  }
}

resource "aws_subnet" "devops-pub-1c" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.44.4.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "devops_public_subnet_1c"
  }
}

resource "aws_subnet" "devops-prv-1c" {
  vpc_id            = aws_vpc.devops_vpc.id
  cidr_block        = "10.44.5.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "devops_private_subnet_1c"
  }
}

