output "public_dns" {
  value = aws_lb.ealb.dns_name
}
