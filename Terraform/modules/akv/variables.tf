# ---------------- METADATA ------------------------
variable "location" {
  description = "The location/region where the VNet is created."
  type        = string
}

variable "location_abbreviation" {
  description = "The short location name, according to DevOps standards."
  type        = string
}

variable "product" {
  description = "The name of the product this VNet is for."
  type        = string
}

variable "environment" {
  description = "The environment this VNet resides within."
  type        = string
}

variable "name_suffix" {
  description = "Optional suffix to append to the VNet name."
  type        = string
  default     = ""
}

variable "vault_resource_name" {
  description = "String used to identify the type of resource being created"
  type        = string
  default     = "vault"
}

variable "tags" {
  description = "Tags to apply to this resource."
  type        = map(string)
}
# ------------- END METADATA -----------------------
#------------------------ AZURE AD OBJECT ID -------------------------#

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "client_object_id" {
  description = "Object ID of the above app (Terraform SP)"
  type        = string
}

variable "access_policy_object_ids" {
  description = "The object IDs that are allowed to access this key vault"
  type        = list(string)
}

#------------------------ END AZURE AD OBJECT ID -------------------------#
#------------------------ SECRETS --------------------------#
variable "secrets" {
  description = "The secrets to add to the vault."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}
#------------------------ END SECRETS --------------------------#

# ---------------------- DEPENDENCIES -----------------------#
variable "resource_group_name" {
  description = "The name of the resource group to create this VNet in."
  type        = string
}
# -------------------- END DEPENDENCIES --------------------#

#----------------PRIVATE ENDPOINT--------------------#
variable "create_private_endpoint" {
  type        = bool
  description = "Create private endpoint for key vault"
  default     = false
}

variable "pe_subnet_id" {
  type        = string
  description = "Subnet to attach Private Endpoint"
  default     = null
}

variable "private_dns_zone" {
  type        = string
  description = "Resource ID of the private dns zone to create the private endpoint dns records in"
  default     = "/subscriptions/xxxxxxxxxxxxxxxxx/resourceGroups/rg-xxxxx-vpn-uaenorth/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
}

#----------------END PRIVATE ENDPOINT--------------------#
#-------------VAULT PROTECTION SETTINGS-------------------#

variable "network_acls" {
  description = "Key Vault Network ACL settings"
  type        = any
  default     = null
}

variable "purge_protection_enabled" {
  description = "To enable/disable KeyVault Purge protection"
  type        = bool
  default     = false
}

variable "enable_resource_lock" {
  description = "To enable/disable KeyVault Resource Lock"
  type        = bool
  default     = false
}
#-------------END VAULT FW SETTINGS-------------------#
