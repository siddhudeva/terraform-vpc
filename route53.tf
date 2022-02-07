resource "aws_route53_zone_association" "private_dns" {
  vpc_id  = aws_vpc.main.id
  zone_id = var.PRIVATE_HOSTEDZONE_ID
}