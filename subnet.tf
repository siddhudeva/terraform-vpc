resource "aws_subnet" "Public_subnets" {
  count             = length(var.PUBLIC_SUBNET_CIDR)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PUBLIC_SUBNET_CIDR[count.index]
  availability_zone = var.AZS[count.index]
  tags = {
    Name = "${var.ENV}-Public_subnet-${count.index + 1}"
    ENV  = var.ENV
  }
}

resource "aws_subnet" "Private_subnets" {
  count             = length(var.PRIVATE_SUBNET_CIDR)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.PRIVATE_SUBNET_CIDR[count.index]
  availability_zone = var.AZS[count.index]

  tags = {
    Name = "${var.ENV}-private_subnet-${count.index + 1}"
    ENV  = var.ENV
  }
}