variable "environment" {
  type = string
  description = "this is the prod environment we are using"
}

variable "vnet_cidr_address_space" {
  description = "CIDR address space"
  type        = string
}

variable "cidr" {
  type = list(object({
    name              = string
    cidr              = list(any)
    subnet_delegation = any
    service_endpoints = any
    sku               = string
  }))
}

variable "new_relic_license_key" {
  description = "The license key for New Relic integrations."
  type        = string
  default     = "#{newrelic-license-key}#"
}

variable "subscription_id" {
  description = "Azure Subscription ID for PhlexVision"
  type        = string
  default     = "xxxxxxxxxx"
}

variable "tenant_id" {
  description = "Azure Tenant ID for PhlexVision"
  type        = string
  default     = "xxxxxxxxxxx"
}

variable "client_id" {
  description = "Client ID/App ID for associated subscription (Terraform SP)"
  type        = string
  default     = "xxxxxxxxxxxxxxx"
}

variable "client_object_id" {
  description = "Object ID of the above app (Terraform SP)"
  type        = string
  default     = "xxxxxxxxxxx"
}

variable "client_secret" {
  description = "Secret for the above app (Terraform SP)"
  type        = string
  default     = "xxxxxxxxxxxxx"
}

variable "subnet_service_endpoints" {
  description = "The service endpoint given for aks subnet."
  type        = any
}

variable "aks_nodes_address_prefix" {
  type = string
  description = "this is prod vnet address space."
}

variable "cluster_node_subnet" {
  description = "The subnet range to put AKS nodes within."
  type        = string
}

variable "kubernetes_version" {
  description = "The subnet range to put AKS nodes within."
  type        = string
  default     = "1.34"
}

variable "subnet_names" {
  description = "The subnet name where AKS will be linked with"
  type        = string
}

variable "app_subnet" {
  type = string
  description = "this is prod aks subnet address prefix."
}

variable "subnet_names" {
  description = "The subnet name where AKS will be linked with"
  type        = string
}

variable "app_subnet_address_prefix" {
  type = string
  description = "this is prod aks subnet address prefix."
}

variable "private_endpoints" {
  type = string
  description = "this is prod aks subnet address prefix."
}

variable "private_endpoints_prefixes" {
  type = string
  description = "this is prod aks subnet address prefix."
}

variable "access_policy_object_ids" {
  type = list(string)
  description = "this is prod env."
}

variable "secrets" {
  description = "The secrets to add to the vault."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "asp_tier" {
  type        = string
  description = "App Service Plan tier."
  default     = "Standard"
}

variable "asp_size" {
  type        = string
  description = "App Service Plan Size."
  default     = "S1"
}

variable "storage_conn_string" {
  type        = string
  description = "App Service Plan Size."
}

variable "subnet_ids" {
  description = "The IDs of the subnets for cast ai"
  type        = list(any)
  default     = []
}

