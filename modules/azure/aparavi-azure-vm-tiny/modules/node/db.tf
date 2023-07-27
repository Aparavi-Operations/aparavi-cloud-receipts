resource "azurerm_mysql_flexible_server_firewall_rule" "db-access" {
  name                = "${var.name}-db-access"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.db.name
  start_ip_address    = azurerm_public_ip.node.ip_address
  end_ip_address      = azurerm_public_ip.node.ip_address
}
resource "azurerm_mysql_flexible_server_firewall_rule" "db-access-ext" {
  for_each            = toset(var.db_access_ips)
  name                = "${var.name}-db-access-${each.key}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.db.name
  start_ip_address    = "${each.value}"
  end_ip_address      = "${each.value}"
}

resource "azurerm_private_dns_zone" "db" {
  name                = "${var.name}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "aparaviVnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.db.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_mysql_flexible_server_configuration" "insecure_db" {
  name                = "require_secure_transport"
  resource_group_name   = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.db.name
  value               = "OFF"
}

resource "azurerm_mysql_flexible_server" "db" {
  name                             = "${var.name}-aparavi"
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
  administrator_login          = var.db_username
  administrator_password = var.db_password
  create_mode                      = "Default"
  backup_retention_days  = 7
  delegated_subnet_id    = var.db_subnet
  private_dns_zone_id    = azurerm_private_dns_zone.db.id
  sku_name               = var.db_shape
  version    = "8.0.21"
  geo_redundant_backup_enabled      = true

  storage {
    size_gb = var.db_size
    auto_grow_enabled                 = true
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.example]
  lifecycle {
    ignore_changes = [
      zone
    ]
  }
  tags = merge(var.tags, {
    Name         = var.name
    component    = var.component
    subcomponent = "rds"
  })
}
