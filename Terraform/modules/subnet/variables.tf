variable "aks_nodes_address_prefix" {
  type = string
  description = "this is prod vnet address prefix."
}

variable "app_subnet_address_prefix" {
  type = string
  description = "this is prod app service subnet address prefix."
}

variable "aks_subnet" {
  type = string
  description = "this is prod aks subnet address prefix."
}

variable "subnet_names" {
  description = "The subnet name where AKS will be linked with"
  type        = string
}

variable "app_subnet" {
  type = string
  description = "this is prod aks subnet address prefix."
}

variable "aks_subnet_address_prefix" {
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


# Subnet Definition

variable "address_prefix" {
  description = "The list of CIDR block(s) for the subnet (e.g., ['10.0.1.0/24'])."
  type        = list(string)
}

# Configuration Options
variable "service_endpoints" {
  description = "A list of service endpoint types to enable (e.g., ['Microsoft.Storage'])."
  type        = list(string)
  default     = []
}

variable "enforce_private_link_endpoint" {
  description = "Controls Private Endpoint Network Policies (set to false for PE subnets)."
  type        = bool
  default     = true
}

variable "enforce_private_link_service" {
  description = "Controls Private Link Service Network Policies."
  type        = bool
  default     = false
}

# Delegation
variable "subnet_delegation" {
  description = "A map defining service delegations for the subnet (e.g., App Service or ACI)."
  type = map(list(object({
    name    = string
    actions = list(string)
  })))
  default = {}
}
