resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV}-igw"
    ENV  = var.ENV
  }
}

#resource "aws_nat_gateway" "example" {
#  allocation_id =
#  subnet_id     = aws_subnet.Private_subnets.*.id
#
#  tags = {
#    Name = "gw NAT"
#  }#