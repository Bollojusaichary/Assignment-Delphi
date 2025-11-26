resource "azurerm_container_registry" "this" {
  name                     = lower("acr${var.product}${var.environment}")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = "Premium"
  admin_enabled            = true
  zone_redundancy_enabled  = true

  georeplications {
    location                = "uaenorth"
    zone_redundancy_enabled = true
  }

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_role_assignment" "aks_pull" {
  scope                = azurerm_container_registry.this.id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_kubelet_identity_id
}
