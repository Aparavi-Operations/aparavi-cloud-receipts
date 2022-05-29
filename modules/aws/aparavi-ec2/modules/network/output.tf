output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "vm_subnet_id" {
  value = aws_subnet.vm_subnet.id
}

output "rds_subnet_id_a" {
  value = aws_subnet.rds_subnet_a.id
}

output "rds_subnet_id_b" {
  value = aws_subnet.rds_subnet_b.id
}
