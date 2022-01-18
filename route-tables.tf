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
#resource "aws_route_table_association" "Public" {
#  count = length(aws_subnet.Public_subnets)
#  subnet_id      = aws_subnet.Public_subnets.*.id
#  route_table_id = aws_route_table.public-route.id
#}
#
#resource "aws_route_table_association" "Private" {
#  count = length(aws_subnet.Private_subnets)
#  subnet_id      = aws_subnet.Private_subnets.*.id
#  route_table_id = aws_route_table.Private-route.id
#}

resource "aws_route_table_association" "Public" {
  count          = "${length(aws_subnet.Public_subnets)}"
  subnet_id      = "${element(aws_subnet.Public_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-route.id}"
}
resource "aws_route_table_association" "Private" {
  count          = "${length(aws_subnet.Private_subnets)}"
  subnet_id      = "${element(aws_subnet.Private_subnets.*.id, count.index)}"
  route_table_id = "${aws_route_table.Private-route.id}"
}
resource "aws_route" "route-public" {
  route_table_id            = aws_route_table.public-route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}
resource "aws_route" "route-private" {
  route_table_id            = aws_route_table.Private-route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_nat_gateway.ngw.id
}