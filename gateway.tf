resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV}-igw"
    ENV  = var.ENV
  }
}
resource "aws_route" "route-public" {
  route_table_id            = aws_route_table.public-route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}

#resource "aws_nat_gateway" "example" {
#  allocation_id =
#  subnet_id     = aws_subnet.Private_subnets.*.id
#
#  tags = {
#    Name = "gw NAT"
#  }#