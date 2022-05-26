
resource "azurerm_virtual_network" "main" {
  name                = "${var.name}-network"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
  //dns_servers         = [cidrhost(var.vnet_cidr, 4), cidrhost(var.vnet_cidr, 5)]

  tags = merge(var.tags, {
    environment = "Production"
  })
}

resource "azurerm_subnet" "public" {
  name                 = "${var.name}-public"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 2, 1)]
}

resource "azurerm_subnet" "private" {
  name                 = "${var.name}-private"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [cidrsubnet(var.vnet_cidr, 2, 2)]
}