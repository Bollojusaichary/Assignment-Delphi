output "location" {
  value = azurerm_resource_group.rg.location
}

output "environment" {
    value = azurerm_resource_group.rg.id
}
