locals {
  fullname = "${var.environment}-${var.location}" 
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${local.fullname}"
  location            = var.location
  resource_group_name = module.resourcegroup.name

  tags = merge({ service = "nsg" }, var.environment,)
}


resource "azurerm_network_security_rule" "allow_http" {
  name                        = "allow-tcp-80"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefixes     = var.allowed_networks
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "allow_https" {
  name                        = "allow-tcp-443"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefixes     = var.allowed_networks
  destination_address_prefix  = "*"
  resource_group_name         = module.resourcegroup.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
