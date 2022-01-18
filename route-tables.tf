resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public_rt"
    ENV  = var.ENV
  }
}

resource "aws_route_table" "Private-route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private_rt"
    ENV  = var.ENV
  }
}

resource "aws_route_table_association" "Public-assign" {
  count = length(aws_subnet.Public_subnets)
  subnet_id      = aws_subnet.Public_subnets.*.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private-assign" {
count = length(aws_subnet.Private_subnets)
  subnet_id      = aws_subnet.Private_subnets.id
  route_table_id = aws_route_table.Private-route.id
}