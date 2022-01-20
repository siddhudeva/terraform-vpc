resource "aws_vpc" "main" {
  enable_dns_hostnames = true
  enable_dns_support = true
  cidr_block = var.VPC_CIDR
  tags = {
    Name = var.ENV
  }
}