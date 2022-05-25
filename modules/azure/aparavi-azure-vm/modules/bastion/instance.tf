resource "azurerm_public_ip" "bastion" {
  name                = "${var.name}-bastionip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "bastion" {
  name                = "${var.name}-bastionnic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.vm_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion.id
    primary                       = true
  }
}

resource "azurerm_network_security_group" "bastion" {
  name                = "${var.name}-bastionsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_security_rule" "bastion-out" {
  name                        = "${var.name}-bastionout-rule"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion.name
}

resource "azurerm_network_security_rule" "bastion-ssh-in" {
  name                        = "${var.name}-bastionssh-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion.name
}

resource "azurerm_network_interface_security_group_association" "bastion" {
  network_interface_id      = azurerm_network_interface.bastion.id
  network_security_group_id = azurerm_network_security_group.bastion.id
}

resource "azurerm_linux_virtual_machine" "bastion" {
  name          = "${var.name}-bastion"
  computer_name = "${var.name}-bastion"
  custom_data   = var.custom_data
  user_data     = var.user_data
  //encryption_at_host_enabled = true

  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = "aparavi"
  network_interface_ids = [
    azurerm_network_interface.bastion.id,
  ]

  admin_ssh_key {
    username   = "aparavi"
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = var.disk_size
    name                 = "${var.name}-bastiondisk"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11-gen2"
    version   = "latest"
  }

  tags = var.tags
}