output "db_instance_address" {
  value       = module.rds.db_instance_address
  description = "The address of the RDS instance"
}

output "db_instance_password" {
  value       = module.rds.db_instance_password
  description = <<EOT
     The database password (this password may be old, because Terraform doesn't
     track it after initial creation)
     EOT
  sensitive   = true
}
