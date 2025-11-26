locals {
  full_name = trimsuffix(join("-", [var.product, var.environment, "vnet", var.location_abbreviation]), "-")
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.full_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name.rg.name
  tags                = merge(var.tags, { service = "vnet" })
}
