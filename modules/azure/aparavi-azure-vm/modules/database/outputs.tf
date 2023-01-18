output "endpoint" {
  value = azurerm_mysql_server.db.fqdn
}

output "server_name" {
  value = azurerm_mysql_server.db.name
}

output "rds_password" {
  value = random_password.rds_password.result
}
