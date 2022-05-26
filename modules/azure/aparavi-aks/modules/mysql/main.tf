resource "random_password" "this" {
  length  = 32
  special = false # APARAVI Data IA Installer misbehaves on some of these.
}

resource "azurerm_mysql_server" "this" {
  name                         = var.name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  tags                         = var.tags
  sku_name                     = var.sku_name
  version                      = "8.0"
  administrator_login          = "aggregator"
  administrator_login_password = random_password.this.result
  storage_mb                   = 5120
  auto_grow_enabled            = true
  ssl_enforcement_enabled      = false
}

resource "azurerm_private_endpoint" "this" {
  name                = "${var.name}-mysql"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.name}-mysql"
    private_connection_resource_id = azurerm_mysql_server.this.id
    subresource_names              = ["mysqlServer"]
    is_manual_connection           = false
  }
}
