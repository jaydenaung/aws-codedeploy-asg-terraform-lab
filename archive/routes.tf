#Devops VPC Route Table

resource "aws_route_table" "devops_pub_route_table" {
  vpc_id = aws_vpc.devops_vpc.id

  # Route to the internet
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devops_internet_gateway.id
  }
  tags = {
    Name = "devops_Public_Route_Table"
  }
}

resource "aws_route_table_association" "devops_table_associatio_2a" {
  subnet_id      = aws_subnet.devops-pub-2a.id
  route_table_id = aws_route_table.devops_pub_route_table.id
}

resource "aws_route_table_association" "devops_table_association_2b" {
  subnet_id      = aws_subnet.devops-pub-2b.id
  route_table_id = aws_route_table.devops_pub_route_table.id
}

resource "aws_route_table_association" "devops_table_association_2c" {
  subnet_id      = aws_subnet.devops-pub-2c.id
  route_table_id = aws_route_table.devops_pub_route_table.id
}

