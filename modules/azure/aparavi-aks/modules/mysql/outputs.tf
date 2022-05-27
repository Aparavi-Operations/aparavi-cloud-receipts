output "address" {
  description = "Cloud SQL instance address"
  value       = azurerm_private_endpoint.this.private_service_connection[0].private_ip_address
}

output "username" {
  description = "Cloud SQL username"
  value = format(
    "%s@%s",
    azurerm_mysql_server.this.administrator_login,
    azurerm_private_endpoint.this.custom_dns_configs[0].fqdn
  )
}

output "password" {
  description = "Cloud SQL password"
  value       = random_password.this.result
  sensitive   = true
}
