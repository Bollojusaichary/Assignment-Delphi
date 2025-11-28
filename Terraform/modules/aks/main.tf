locals {
  fullname = "${var.environment}-${var.location}" 
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks--${var.environment}"
  location            = var.location
  resource_group_name = module.resource_group.name
  dns_prefix          = lower("aks--${var.environment}")

  default_node_pool {
    name           = "aksnode-${local.fullname}"
    vm_size        = "Standard_D8s_v5"
    zones          = ["1", "2", "3"]
    # enable_auto_scaling = true
    min_count      = 3
    max_count      = 5
    node_count     = 3
    os_disk_size_gb = 128
    vnet_subnet_id = azurerm_subnet.akssubnet.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }

  azure_policy_enabled = true
  local_account_disabled = true
  role_based_access_control_enabled = true

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity.object_id
}
