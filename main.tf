
resource "aws_subnet" "Public_subnets" {
  count = lenght(var.PUBLIC_SUBNET_CIDR)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.PUBLIC_SUBNET_CIDR[count.index]

  tags = {
    Name = "Public_subnet"
  }
}

resource "aws_subnet" "Private_subnets" {
  count = length(var.PRIVATE_SUBNET_CIDR)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.PRIVATE_SUBNET_CIDR[count.index]

  tags = {
    Name = "private_subnet"
  }
}