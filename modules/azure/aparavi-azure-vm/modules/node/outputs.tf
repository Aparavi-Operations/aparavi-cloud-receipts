output "node_private_ip" {
  value = azurerm_network_interface.node.private_ip_address
}

output "node_public_ip" {
  value = azurerm_public_ip.node.ip_address
}

output "node_endpoint" {
  value = azurerm_network_interface.node.internal_dns_name_label
}

output "node_identity" {
  value = azurerm_linux_virtual_machine.node.identity
}

output "node_name" {
  value = azurerm_linux_virtual_machine.node.name
}