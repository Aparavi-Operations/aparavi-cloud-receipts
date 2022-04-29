output "node_private_ip" {
  value = azurerm_network_interface.bastion.private_ip_address
}

output "node_public_ip" {
  value = azurerm_public_ip.bastion.ip_address
}