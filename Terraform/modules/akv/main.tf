resource "azurerm_key_vault" "this" {
  name                        = "kv-${var.project_name}-${var.environment}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "premium"
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = []
  }

  tags = {
    Environment = var.environment
  }
}

# Give Terraform runner full admin rights
resource "azurerm_role_assignment" "terraform_admin" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = var.current_object_id
}

# Allow AKS to read secrets
resource "azurerm_role_assignment" "aks_secrets_reader" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.aks_kubelet_identity_id
}