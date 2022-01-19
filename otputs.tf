output "VPC_ID" {
  value = aws_vpc.main.id
}
output "public_subnet" {
  value = aws_subnet.Public_subnets.*.id
}
output "private_subnet" {
  value = aws_subnet.Private_subnets.*.id
}
output "VPC-CIDR" {
  value = var.VPC_CIDR
}
output "PUBLIC_CIDR" {
  value = var.PUBLIC_SUBNET_CIDR
}

output "PRIVATE_CIDR" {
  value = var.PRIVATE_SUBNET_CIDR
}
