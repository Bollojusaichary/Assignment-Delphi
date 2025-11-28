resource "azurerm_subnet" "subnet" {
  name                                           = var.subnet_names
  resource_group_name                            = module.resourcegroup.name
  virtual_network_name                           = module.vnet.name
  address_prefixes                               = var.address_prefix
  service_endpoints                              = var.service_endpoints
  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint
  enforce_private_link_service_network_policies  = var.enforce_private_link_service


  dynamic "delegation" {
    for_each = var.subnet_delegation
    content {
      name = delegation.key
      dynamic "service_delegation" {
        for_each = toset(delegation.value)
        content {
          name    = service_delegation.value.name
          actions = service_delegation.value.actions
        }
      }
    }
  }
}

