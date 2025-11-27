module "resource_group" {
  source = "./modules/resource_group"

  location              = var.location
  environment           = var.environment
  tags                  = local.tags
}


module "keyvault" {
  source = "./modules/keyvault"

  vault_resource_name       = module.keyvault.name
  location                  = var.location
  resource_group_name       = module.resource_group.name
  environment               = var.environment
  tags                      = merge(local.tags, { service = "kv" })
  access_policy_object_ids  = azurerm.key_vault.keyvault.id
  client_object_id          = var.client_object_id
  tenant_id                 = var.tenant_id
}

module "vnet" {
  source = "./modules/vnet"
  providers = {
    azurerm.bastion = azurerm.bastion
  }
  tags                    = merge(local.tags, { service = "vnet" })
  environment             = var.environment
  location                = var.location
  vnet_cidr_address_space = var.vnet_cidr_address_space
}


module "acr" {
  source = "./modules/ACR"

  location                  = var.location
  environment               = var.environment
  aks_kubelet_identity_id   = "ssdf"
}

# create AKS node pool subnet
resource "azurerm_subnet" "cluster_node_pool_subnet" {
  name                 = var.sub_net.names
  resource_group_name  = module.resource_group.name
  virtual_network_name = module.network.vnet
  address_prefixes     = [var.cluster_node_subnet]
  service_endpoints    = var.subnet_service_endpoints
}

resource "azurerm_subnet_network_security_group_association" "cluster_node_pool_subnet_nsg" {
  subnet_id                 = azurerm_subnet.cluster_node_pool_subnet.id
  network_security_group_id = module.nsg.id
}

module "aks" {
  source = "./modules.phlexglobal.com/devops/akscluster/azure"
  providers = {
    azurerm.acr = azurerm.acr
  }

  version                 = "0.5.3"
  location                = var.location
  environment             = var.environment
  tags                    = merge(local.tags, { service = "aks" })
  resource_group_name     = module.resource_group.name
  availability_zones      = [1, 2, 3]
  node_pool_subnet_id     = azurerm_subnet.cluster_node_pool_subnet.id
  node_vm_class           = var.vmsize
  azure_policy_enabled    = var.azure_policy_enabled
}

module "aks_resources" {
  source = "modules.phlexglobal.com/devops/aksresources/azure"

  version                        = "1.0.10"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  node_resource_group            = module.aks.node_resource_group
  aks_name                       = module.aks.name
  cluster_name                   = module.aks.name
  nginx_ingress_chart_version    = "4.8.2"
  new_relic_bundle_chart_version = "5.0.41" #To support lowDataMode
  install_nginx_ingress          = var.install_nginx_ingress
  install_cert_manager           = var.install_cert_manager
  install_new_relic_bundle       = var.install_new_relic_bundle
  nginx_ingress_replica_count    = var.nginx_ingress_replica_count
}

module "app_service" {
  source = "./modules/app_service"
 
  location              = var.location
  environment           = var.environment
  tags                  = merge(local.tags, { service = "webapp" })

  asp_tier            = var.asp_tier
  asp_size            = var.asp_size
  subnet_id           = module.network.subnet_id_webapp
  storage_conn_string = module.storage_account.connection_string
  identity_type       = ["SystemAssigned", "UserAssigned"]
  identity_ids        = ["${data.azurerm_user_assigned_identity.identity.id}"]
}

module "subnet" {
  source = "./modules/subnet"
  providers = {
    azurerm.bastion = azurerm.bastion
  }
  tags                    = merge(local.tags, { service = "subnet" })
  environment             = var.environment
  location                = var.location
  vnet_name               = module.vnet.name
  vnet_cidr_address_space = var.vnet_cidr_address_space
  service_endpoints       = ["Microsoft.Web"]
}
