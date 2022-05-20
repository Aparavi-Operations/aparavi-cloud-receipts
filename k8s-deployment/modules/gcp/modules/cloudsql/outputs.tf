output "address" {
  description = "Cloud SQL instance address"
  value       = google_sql_database_instance.this.private_ip_address
}

output "password" {
  description = "Password of user 'aggregator'"
  value       = random_password.password.result
  sensitive   = true
}
