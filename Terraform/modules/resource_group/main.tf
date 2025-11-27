locals {
  full_name = trimsuffix(join("-", [var.environment]), "-")
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.full_name}"
  location = var.location
  tags     = merge(var.tags, { service = "rg" })
}
