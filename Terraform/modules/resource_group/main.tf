locals {
  fullname = "${var.environment}-${var.location}"
}

resource "azurerm_resource_group" "rg" {
    name = "rg-${local.fullname}"
    location = var.location

    tags = merge(var.environment, {service = "rg"})
}
