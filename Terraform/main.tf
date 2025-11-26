module "resource_group" {
  source = "./modules/resource_group"

  location              = var.location
  location_abbreviation = var.location_abbreviation
  product               = var.product
  environment           = var.environment
  tags                  = local.tags
}

module "key_vault" {
  source = "./modules/key_vault"
  vault_resource_name   = var.keyvault_name
  location              = var.location
  location_abbreviation = var.location_abbreviation
  product               = var.product
  environment           = var.environment
  tags                  = merge(local.tags, { service = "kv" })
  access_policy_object_ids = azurerm.key_vault.keyvault.id

module "network" {
  source = "./modules/network"
  providers = {
    azurerm.bastion = azurerm.bastion
  }
  tags                  = merge(local.tags, { service = "vnet" })
  environment           = var.environment
  product               = var.product
  location              = var.location
  location_abbreviation = var.location_abbreviation
  resource_group_name   = module.resource_group.name
  vnet_address_space    = [var.vnet_cidr_address_space]
  subnet_names          = local.subnet_cidr
}

# create AKS node pool subnet
resource "azurerm_subnet" "cluster_node_pool_subnet" {
  name                 = var.subnet_names
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
  source = "modules.phlexglobal.com/devops/akscluster/azure"
  providers = {
    azurerm.acr = azurerm.acr
  }

  version                 = "0.5.3"
  location                = var.location
  location_abbreviation   = var.location_abbreviation
  product                 = var.product
  environment             = var.environment
  tags                    = merge(local.tags, { service = "aks" })
  private_cluster_enabled = false
  resource_group_name     = module.resource_group.name
  is_production           = var.is_production
  aks_sku_tier            = var.is_production == true ? "Standard" : "Free"
  availability_zones      = [1, 2, 3]
  enable_auto_upgrades    = var.enable_auto_upgrades
  aks_upgrade_day         = var.aks_upgrade_day
  node_pool_subnet_id     = azurerm_subnet.cluster_node_pool_subnet.id
  min_node_count          = var.min_node_count
  max_node_count          = var.max_node_count
  max_pods_per_node       = var.max_pods_per_node
  node_vm_class           = var.vmsize
  aks_upgrade_hours       = var.aks_upgrade_hours
  enable_auto_scaling     = var.enable_auto_scaling
  cluster_channel_upgrade = "stable"
  azure_policy_enabled    = var.azure_policy_enabled
}

module "aks_resources" {
  source = "modules.phlexglobal.com/devops/aksresources/azure"

  version                  = "1.0.10"
  location                 = var.location
  stormforge_client_secret = var.stormforge_client_secret
  #resource_group_name            = module.resource_group.name
  node_resource_group = module.aks.node_resource_group
  is_production       = var.is_production
  aks_name            = module.aks.name
  cluster_name        = module.aks.name
  #aks_version                    = data.azurerm_kubernetes_cluster.aks.kubernetes_version
  nginx_ingress_chart_version    = "4.8.2"
  new_relic_bundle_chart_version = "5.0.41" #To support lowDataMode
  cert_manager_chart_version     = "1.12.2"
  install_nginx_ingress          = var.install_nginx_ingress
  install_keda                   = var.install_keda
  stormforge_install_agent       = var.stormforge_install_agent
  stormforge_install_applier     = var.stormforge_install_applier
  install_cert_manager           = var.install_cert_manager
  install_new_relic_bundle       = var.install_new_relic_bundle
  nginx_ingress_replica_count    = var.nginx_ingress_replica_count
  new_relic_license_key          = var.new_relic_license_key
  install_content                = var.install_aks_content
  developer_security_groups      = var.aks_access_security_groups_oids
}

##KUBERNETES RESIURCES
#CLUSTER-ISSUER
resource "kubernetes_manifest" "cluster-issuer" {
  count      = var.install_aks_cluster_issuer ? 1 : 0
  manifest   = yamldecode(file("${path.module}/cluster-issuer.yaml"))
  depends_on = [module.aks]
}

module "app_service" {
  source = "./modules/app_service"

  resource_group_name   = module.resource_group.name
  location              = var.location
  location_abbreviation = var.location_abbreviation
  product               = var.product
  environment           = var.environment
  tags                  = merge(local.tags, { service = "webapp" })

  asp_tier            = var.web_asp_tier
  asp_size            = var.web_asp_size
  subnet_id           = module.network.subnet_id_webapp
  storage_conn_string = module.storage_account.connection_string
  identity_type       = "SystemAssigned, UserAssigned"
  identity_ids        = ["${data.azurerm_user_assigned_identity.identity.id}"]
}
