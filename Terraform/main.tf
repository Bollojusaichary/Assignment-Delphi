# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Network Module
module "network" {
  source = "./modules/vnet"

  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  project_name       = var.project_name
  environment        = var.environment
  vnet_address_space = var.vnet_address_space
  tags               = var.tags
}

# ACR Module
module "acr" {
  source = "./modules/acr"

  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  project_name       = var.project_name
  environment        = var.environment
  tags               = var.tags
}

# Key Vault Module
module "key_vault" {
  source = "./modules/akv"
  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  project_name       = var.project_name
  environment        = var.environment
  tags               = var.tags
}

# AKS Module
module "aks" {
  source = "./modules/aks"

  resource_group_name     = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  project_name           = var.project_name
  environment            = var.environment
  vnet_id                = module.network.vnet_id
  subnet_id              = module.network.aks_subnet_id
  acr_id                 = module.acr.acr_id
  key_vault_id           = module.key_vault.key_vault_id
  aks_version            = var.aks_version
  node_count             = var.aks_node_count
  vm_size                = var.aks_vm_size
  tags                   = var.tags

  depends_on = [module.network, module.acr, module.key_vault]
}

# App Service Module
module "appservice" {
  source = "./modules/appservice"

  resource_group_name = azurerm_resource_group.main.name
  location           = azurerm_resource_group.main.location
  project_name       = var.project_name
  environment        = var.environment
  tags               = var.tags
}