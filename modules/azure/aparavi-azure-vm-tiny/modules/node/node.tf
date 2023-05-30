locals {
  init_options = var.init_options != "" ? var.init_options : "-n appagt -c ${var.client_name} -p '${var.db_password}' -o ${var.parent_object} -h ${azurerm_mysql_flexible_server.db.fqdn} -m ${var.db_username} -a ${var.platform_endpoint} -l ${var.logstash_endpoint}"
  user_data = <<EOF
## template: jinja
#!/bin/bash
curl -L -o /root/${var.init_repo}-${var.init_repo_branch}.zip https://github.com/${var.init_repo_org}/${var.init_repo}/archive/${var.init_repo_branch}.zip
while fuser /var/lib/dpkg/lock /var/lib/apt/lists/lock /var/cache/apt/archives/lock >/dev/null 2>&1; do echo 'Waiting for release of dpkg/apt locks'; sleep 5; done;

apt-get -o DPkg::Lock::Timeout=180 update -y
apt-get -o DPkg::Lock::Timeout=180 install -y unzip
unzip /root/${var.init_repo}-${var.init_repo_branch}.zip -d /root
/root/${var.init_repo}-${var.init_repo_branch}/${var.init_script} ${local.init_options}
EOF
}

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

resource "azurerm_linux_virtual_machine" "node" {
  name          = "${var.name}-vm"
  computer_name = "${var.name}-${replace(azurerm_public_ip.node.ip_address, ".", "-")}"
  custom_data   = var.custom_data
  user_data = base64encode(local.user_data)
  //encryption_at_host_enabled = true

  tags = merge(var.tags, {
    Name         = var.name
    component    = var.component
    subcomponent = "app"
  })

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
}
