output "connect_endpoint" {
  value = aws_db_instance.rds.endpoint
}

output "connect_address" {
  value = aws_db_instance.rds.address
}

output "connect_port" {
  value = aws_db_instance.rds.port
}
