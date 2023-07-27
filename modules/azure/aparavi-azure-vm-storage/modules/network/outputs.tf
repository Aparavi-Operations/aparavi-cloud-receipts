output "public_subnet" {
  value = azurerm_subnet.public.id
}
output "db_subnet" {
  value = azurerm_subnet.db.id
}
