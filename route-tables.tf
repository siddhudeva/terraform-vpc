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

resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.public-route.id
}
resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.main.id
  route_table_id = aws_route_table.Private-route.id
}