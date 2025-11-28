locals {
  fullname = "${var.environment}-${var.location}" 
}

resource "azurerm_key_vault" "kv" {
  name          = "kv"-"${local.fullname}"
  location      = var.location
  resource_group_name = module.resource_group.name
  sku_name      = "Standard"
  tenant_id     = var.tenant_id
  tags          = merge({service = kv},var.environment) 

  purge_protection_enabled = var.purge_protection_enabled
}

resource "azurerm_key_vault_access_policy" "tf_access_policy" {
    key_vault_id = azurerm_key_vault.kv.id
    tenant_id    = var.tenant_id
    object_id    = var.client_object_id

    secret_permissions = ["Get", "List", "Set"]
}

resource "azurerm_key_vault_access_policy" "kv_access_policy" {
    for_each = length(var.access_policy_object_ids) > 0 ? toset(var.access_policy_object_ids) : []

    key_vault_id = azurerm_key_vault.kv.id
    tenant_id    = var.tenant_id
    object_id    = var.client_object_id

    secret_permissions = ["Get", "List", "Set"]
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = { for secret in var.secrets : secret.name => secret }

  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_private_endpoint" "kv_private_endpoint" {
  name                = "kv-pe-${local.fullname}"
  location            = var.location
  resource_group_name = module.resource_group.name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "kv-psc-${local.fullname}"
    private_connection_resource_id = azurerm_key_vault.kv.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }
}
