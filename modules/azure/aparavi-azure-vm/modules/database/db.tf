resource "random_password" "rds_password" {
  length  = 24
  special = false
}
resource "azurerm_mysql_firewall_rule" "db-access" {
  for_each            = var.db_access_ips
  name                = "${var.name}-db-access-${each.key}"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.db.name
  start_ip_address    = "${each.value}"
  end_ip_address      = "${each.value}"
}
resource "azurerm_mysql_server" "db" {
  name                             = "${var.name}-db"
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
  create_mode                      = "Default"
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = false
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled"

  administrator_login          = "aparavi"
  administrator_login_password = random_password.rds_password.result

  sku_name   = var.db_shape
  storage_mb = var.db_size
  version    = "8.0"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  tags                              = var.tags
}