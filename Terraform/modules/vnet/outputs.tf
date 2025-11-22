output "vnet_id" {
  description = "Virtual Network ID"
  value       = azurerm_virtual_network.main.id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = azurerm_virtual_network.main.name
}

output "aks_subnet_id" {
  description = "AKS subnet ID"
  value       = azurerm_subnet.aks.id
}

output "app_service_subnet_id" {
  description = "App Service subnet ID"
  value       = azurerm_subnet.app_service.id
}

output "key_vault_subnet_id" {
  description = "Key Vault subnet ID"
  value       = azurerm_subnet.key_vault.id
}

output "private_endpoints_subnet_id" {
  description = "Private endpoints subnet ID"
  value       = azurerm_subnet.private_endpoints.id
}

output "network_security_group_id" {
  description = "Network Security Group ID"
  value       = azurerm_network_security_group.aks.id
}