locals {
  full_name = trimsuffix(join("-", [var.product, var.environment, var.vault_resource_name, var.location_abbreviation]), "-")
}

# used for getting the current tenant ID
data "azurerm_client_config" "current" {}

# first create the key vault
resource "azurerm_key_vault" "keyvault" {
  name                = local.full_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id
  tags                = merge(var.tags, { service = "kv" })

  purge_protection_enabled = var.purge_protection_enabled

}

# create an access policy to let Terraform access stuff
resource "azurerm_key_vault_access_policy" "terraform_access_policy" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id
  object_id    = var.client_object_id

  secret_permissions = ["Get", "List", "Set"]
}

# now create access policies for the given object IDs
resource "azurerm_key_vault_access_policy" "keyvault_access_policy" {
  for_each = length(var.access_policy_object_ids) > 0 ? toset(var.access_policy_object_ids) : []

  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id
  object_id    = each.value

  secret_permissions = ["Get", "List", "Set"]
}


resource "azurerm_key_vault_secret" "key_vault_secret" {
  for_each = { for secret in var.secrets : secret.name => secret }

  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.keyvault.id
}

#Private Endpoint for Key-Vault

resource "azurerm_private_endpoint" "phlexvision_kv_private_endpoint" {
  count               = var.create_private_endpoint == true ? 1 : 0
  name                = "${local.full_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${local.full_name}-psc"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "devops-bastion"
    private_dns_zone_ids = [var.private_dns_zone]
  }
  tags = merge(var.tags, { service = "private-endpoint" })

  depends_on = [azurerm_key_vault.keyvault]
}

#Resource lock for Key-Vault
resource "azurerm_management_lock" "key_vault" {
  count      = var.enable_resource_lock == true ? 1 : 0
  name       = "${local.full_name}-lock"
  scope      = azurerm_key_vault.keyvault.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent un-authorized or accidental deletion"
}
