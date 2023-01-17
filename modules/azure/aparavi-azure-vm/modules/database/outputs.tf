output "endpoint" {
  value = azurerm_mysql_server.db.fqdn
}

output "server_name" {
  value = azurerm_mysql_server.db.name
}