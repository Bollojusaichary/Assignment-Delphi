locals {
  subnets     = var.subnet_names
  subnetnames = { for subnet in local.subnets : subnet.name => subnet }
}

module "vnet" {
  source = "../vnet"

  location              = var.location
  environment           = var.environment
  vnet_address_space  = var.vnet_address_space
}

module "subnet" {
  source               = "./subnet"
  for_each             = local.subnetnames
  subnet_name          = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = module.vnet.name

  address_prefix                = each.value.cidr
  service_endpoints             = lookup(each.value, "service_endpoints", [])
  subnet_delegation             = lookup(each.value, "subnet_delegation", {})
  enforce_private_link_endpoint = lookup(each.value, "enforce_private_link_endpoint", true)
}
