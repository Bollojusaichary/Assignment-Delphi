module "resourcegroup" {
  source = "./modules/resourcegroup"

  location              = var.location
  environment           = var.environment
}

module "keyvault" {
  source = "./modules/keyvault"

  vault_resource_name   = module.keyvault.name 
  location              = var.location
  environment           = var.environment
  tags                  = merge({ service = "kv"}, var.environment)

  tenant_id        = var.tenant_id
  client_object_id = var.client_object_id

  purge_protection_enabled = var.purge_protection_enabled

  secrets = var.create_key_vault_private_endpoint ? concat([
    {
      name  = "NewRelicLicenseKey"
      value = var.new_relic_license_key
    },
    {
      name  = "SubscriptionKey"
      value = var.subscription_id
    },
  ], local.keyvault_secrets) : []

  resource_group_name      = module.resource_group.name
  access_policy_object_ids = var.create_key_vault_private_endpoint ? local.access_policy_object_ids : []

  create_private_endpoint = var.create_key_vault_private_endpoint
  pe_subnet_id            = var.create_key_vault_private_endpoint ? module.network.subnet_id : null

  network_acls = var.create_key_vault_private_endpoint ? {
    kv_nacls_bypass_rule    = "None" #Allowed values = 'AzureServices' and 'None'
    kv_nacls_default_action = "Deny"
    kv_nacls_subnet_ids     = [module.network.subnet_id_webapp, azurerm_subnet.cluster_node_pool_subnet.id]
  } : null

  depends_on = [module.SQL, module.app_service, module.aks]
}


module "network" {
  source = "./modules/network"
  providers = {
    azurerm.bastion = azurerm.bastion
  }
  tags                  = merge({ service = "vnet" }, var.environment)
  environment           = var.environment
  location              = var.location
  resource_group_name   = module.resourcegroup.name
  vnet_address_space    = [var.vnet_cidr_address_space]
  subnet_names          = local.subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "cluster_node_pool_subnet_nsg" {
  subnet_id                 = azurerm_subnet.cluster_node_pool_subnet.id
  network_security_group_id = module.nsg.id
}

resource "azurerm_subnet" "cluster_node_pool_subnet" {
  name                 = var.subnet_names
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.network.vnet
  address_prefixes     = [var.cluster_node_subnet]
  service_endpoints    = var.subnet_service_endpoints
}

module "AKS" {
  source = "./modules/AKS"

  tags                = merge({ service = "AKS" }, var.environment)
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resourcegroup.name

  aks_name            = module.AKS.name
  kubernetes_version  = var.kubernetes_version

  node_pool_name      = var.node_pool_name
  vnet_subnet_id      = module.network.subnet_ids["aks"]
}

module "ACR" {
  source = "./modules/ACR"

  tags                = merge({ service = "acr"}, var.environment)
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resourcegroup.name

  acr_name            = module.ACR.name
  sku                 = "Standard"
  admin_enabled       = true

  # ----------------------------
  # Network Rules (Optional)
  # ----------------------------
  public_network_access_enabled = var.acr_public_network_access_enabled   # false = private only
  allowed_ip_ranges             = var.acr_allowed_ip_ranges               # ["X.X.X.X/32", ...]

  # ----------------------------
  # Private Endpoint (Optional)
  # ----------------------------
  private_endpoint_enabled      = var.acr_private_endpoint_enabled
  subnet_id                     = module.network.subnet_ids["acr-pe"]     # your PE subnet
}

