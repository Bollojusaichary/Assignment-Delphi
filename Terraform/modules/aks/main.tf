resource "azurerm_virtual_network" "aksvnet" {
  name                = "vnet-aks-${var.environment}"
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "akssubnet" {
  name                 = "snet-aks"
  resource_group_name  = module.resource_group.name
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${var.environment}"
  location            = var.location
  resource_group_name = module.resource_group.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks--${var.environment}"
  location            = var.location
  resource_group_name = module.resource_group.name
  dns_prefix          = lower("aks--${var.environment}")

  default_node_pool {
    name           = "prodpool"
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

  oms_agent {
    # enabled                    = true
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  }

  azure_policy_enabled = true
  local_account_disabled = true
  role_based_access_control_enabled = true

  tags = {
    Environment = var.environment
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity.object_id
}
