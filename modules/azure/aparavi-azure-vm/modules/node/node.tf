resource "azurerm_public_ip" "node" {
  name                = "${var.name}-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "node" {
  name                = "${var.name}-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.node.id
    primary                       = true
  }
}

resource "azurerm_network_security_group" "node" {
  name                = "${var.name}-sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = var.tags
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

resource "azurerm_network_security_rule" "node-ssh-in" {
  name                        = "${var.name}-ssh-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
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
  source_address_prefix       = lookup(each.value, "source", "VirtualNetwork")
  destination_address_prefix  = lookup(each.value, "destination", "VirtualNetwork")
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.node.name
}

resource "azurerm_network_interface_security_group_association" "node" {
  network_interface_id      = azurerm_network_interface.node.id
  network_security_group_id = azurerm_network_security_group.node.id
}

resource "azurerm_linux_virtual_machine" "node" {
  name          = "${var.name}-vm"
  computer_name = "${var.name}-${replace(azurerm_public_ip.node.ip_address, ".", "-")}"
  custom_data   = var.custom_data
  user_data     = var.user_data
  //encryption_at_host_enabled = true

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = "aparavi"
  network_interface_ids = [
    azurerm_network_interface.node.id,
  ]

  dynamic "identity" {
    for_each = toset(var.identity)
    content {
      type         = identity.value["type"]
      identity_ids = lookup(identity.value, "identity_ids", [])
    }
  }
  admin_ssh_key {
    username   = "aparavi"
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = var.disk_size
    name                 = "${var.name}-disk"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11-gen2"
    version   = "latest"
  }

  tags = merge({
    "Name" = "${var.name}-vm"
  }, var.tags)
}