output "public_subnet" {
  value = azurerm_subnet.public.id
}

output "db_subnet" {
  value = azurerm_subnet.db.id
}

output "virtual_network_id" {
  value = azurerm_virtual_network.main.id
}
output "virtual_network_name" {
  value = azurerm_virtual_network.main.name
}
