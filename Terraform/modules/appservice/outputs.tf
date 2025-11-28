output "asp_id" {
  value = azurerm_app_service_plan.asp.id
}

output "app_service_possible_outbound_ip_address_list" {
  value = var.environment != "prod" ? azurerm_app_service.app_service[0].possible_outbound_ip_address_list : null
}

output "app_service_outbound_ip_address_list" {
  value = var.environment != "prod" ? azurerm_app_service.app_service[0].outbound_ip_address_list : null
}

output "app_service_identity" {
  value = var.environment != "prod" ? azurerm_app_service.app_service[0].identity[0].principal_id : null
}
