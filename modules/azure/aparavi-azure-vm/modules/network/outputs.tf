output "public_subnet" {
  value = azurerm_subnet.public.id
}

output "private_subnet" {
  value = azurerm_subnet.private.id
}