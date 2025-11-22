output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.main.name
}

output "aks_cluster_name" {
  description = "AKS cluster name"
  value       = module.aks.aks_name
}

output "acr_name" {
  description = "ACR name"
  value       = module.acr.acr_name
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = module.key_vault.key_vault_name
}

output "app_service_url" {
  description = "App Service URL"
  value       = "https://${module.appservice.default_hostname}"
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = module.network.vnet_name
}