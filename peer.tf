/// Peering connection is used to connect two VPCs.. Then they can talk to each other without going to internet.
/// If you want to have connection in between 3 or 4 VPCs then you require 8 VPC peering connection. so alternative to this problem is AWS offerd AWS Direct Connect connection.
resource "aws_vpc_peering_connection" "peer-vpcs" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.main.id
  vpc_id        = data.aws_vpc.default.id
  auto_accept   = true
}