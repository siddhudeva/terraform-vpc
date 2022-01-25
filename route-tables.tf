/// route table is a set of rules.often viewed as a table, that is used to determine the where the traffic goes means IPs wants to route
/// Route table will become public or private based on the inbound rules.if you open the route to 0.0.0.0/0 that is every where internet so this means public
resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public_rt"
    ENV  = var.ENV
  }
}
//// if you keep your routes internally withoout routing to outside world then it is known as private routetable
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
////here we are trying to associate route table with instances , we are choosenly assigning it to Public routetables so they will have public access
resource "aws_route_table_association" "Public" {
  count          = length(aws_subnet.Public_subnets)
  subnet_id      = aws_subnet.Public_subnets.*.id[count.index]
  route_table_id = aws_route_table.public-route.id
}
//// This is a private table that we are associating with instances so those instances are doesn't get the INternet directly
resource "aws_route_table_association" "Private" {
  count          = length(aws_subnet.Private_subnets)
  subnet_id      = aws_subnet.Private_subnets.*.id[count.index]
  route_table_id = aws_route_table.Private-route.id
}
/// here we are connecting the public route table with internet gateway. because internet ony comes through igw only..here asking internet using (0.0.0.0/0)
resource "aws_route" "route-public" {
  route_table_id         = aws_route_table.public-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}
//// in order to get internet to private resources, the private routetable will connect to the Nat gateway asking for  internet.(0.0.0.0/0)
resource "aws_route" "route-private" {
  route_table_id         = aws_route_table.Private-route.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}
////THE BELOW 2 ROUTES ARE CONNECTIONS FROM DEFAULT VPC TO MAIN VPC
//// Peering connection will connect to Public route table that become public peer connection
resource "aws_route" "peer-public" {
  route_table_id            = aws_route_table.public-route.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpcs.id
}
//// Peering connection will connect to Private route table that become private peer connection
resource "aws_route" "peer-private" {
  route_table_id            = aws_route_table.Private-route.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpcs.id
}
//// this is route is to connect Main VPC to Default VPC.
resource "aws_route" "peer-default" {
  route_table_id            = data.aws_vpc.default.main_route_table_id
  destination_cidr_block    = var.VPC_CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.peer-vpcs.id
}