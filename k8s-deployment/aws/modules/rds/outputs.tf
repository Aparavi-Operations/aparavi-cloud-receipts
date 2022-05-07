output "db_instance_address" {
  value       = aws_db_instance.this.address
  description = "The address of the RDS instance"
}

output "db_instance_password" {
  value       = random_password.this.result
  description = <<EOT
     The database password (this password may be old, because Terraform doesn't
     track it after initial creation)
     EOT
  sensitive   = true
}
