////internet gateway is the one,through which internet comes to inside the VPC.and its sits at the edge of VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV}-igw"
    ENV  = var.ENV
  }
}
//// epi is a static IP. which does  not change with time. here we required it because our nat gateway should allocated with "Elastic IP address which is eip"
resource "aws_eip" "nat-gw" {
  vpc = true
  tags = {
    Name = "${var.ENV}-nat-gw-ip"
    ENV  = var.ENV
  }
}
/// natgateway is the one which provides internet to the private resources like dbs and it will not allow the traffic from outside world to inside to the private subnet resources
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat-gw.id
  subnet_id     = aws_subnet.Public_subnets.*.id[0]    /// mentioning [0]. means here we want Nat gateway pick one IP between 2 IPs.
////Natgateway will be in Public subnets and it will hava a connection with private subnets
  tags = {
    Name = "${var.ENV}-ngw"
    ENV  = var.ENV
  }
}