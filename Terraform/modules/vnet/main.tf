locals {
  fullname = "${var.environment}-${var.location}" 
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"-"${local.fullname}"
  resource_group_name = module.resource_group.name
  location            = var.location
  address_space       = var.vnet_address_space
  tags                = merge(var.environment, {service = "vnet"})    
}
