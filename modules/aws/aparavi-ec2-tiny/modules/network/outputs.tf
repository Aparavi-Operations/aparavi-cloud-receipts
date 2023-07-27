output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "rds_subnet_ids" {
  value = [for subnet in aws_subnet.rds_subnets : subnet.id]
}
