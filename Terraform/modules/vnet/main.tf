locals {
  full_name = trimsuffix(join(var.environment,"vnet"))
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.full_name
  address_space       = var.vnet_cidr_address_space
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = merge(var.tags, { service = "vnet" })
}
