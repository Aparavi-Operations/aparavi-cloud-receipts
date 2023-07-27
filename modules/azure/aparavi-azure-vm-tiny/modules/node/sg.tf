resource "azurerm_network_security_group" "node" {
  name                = "${var.name}-sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "node" {
  network_interface_id      = azurerm_network_interface.node.id
  network_security_group_id = azurerm_network_security_group.node.id
}

resource "azurerm_network_security_rule" "node-out" {
  name                        = "${var.name}-rule"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.node.name
}

resource "azurerm_network_security_rule" "node-specific-in" {
  for_each                    = var.fw_ports
  name                        = "${var.name}-${each.key}-rule"
  priority                    = lookup(each.value, "priority", 200)
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = lookup(each.value, "protocol", "Tcp")
  source_port_range           = "*"
  destination_port_range      = each.value.port
  source_address_prefixes     = lookup(each.value, "source", ["VirtualNetwork"])
  destination_address_prefix  = lookup(each.value, "destination", "VirtualNetwork")
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.node.name
}

resource "azurerm_network_security_rule" "node-ssh-in" {
  name                        = "${var.name}-ssh-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.node.name
}
