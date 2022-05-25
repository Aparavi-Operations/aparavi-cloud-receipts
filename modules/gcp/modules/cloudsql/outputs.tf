output "address" {
  description = "Cloud SQL instance address"
  value       = google_sql_database_instance.this.private_ip_address
}

output "username" {
  description = "Cloud SQL username"
  value       = google_sql_user.user.name
}

output "password" {
  description = "Cloud SQL password"
  value       = random_password.password.result
  sensitive   = true
}
