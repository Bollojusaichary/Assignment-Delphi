variable "vnet_address_space" {
  description = "The subnet address space to be assigned to the VNET."
  type        = list(string)
}

variable "environment" {
  type = string
  description = "this is prod env."
}

variable "location" {
  type = string
  description = "this is prod location."
}

variable "subnet_names" {
  type        = any
  description = "Specifies the name for the network subnet"
}

variable "enforce_private_link_endpoint" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet"
  type        = bool
  default     = false
}

variable "enforce_private_link_service" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet.Conflicts with enforce_private_link_endpoint and either one is specified and not the both"
  type        = bool
  default     = false
}

variable "service_endpoints" {
  type        = list(string)
  description = "List of service endpoints to enable on the subnet, e.g. Microsoft.Storage"
  default     = null
}

variable "delegation" {
  type        = any
  description = "Delegations to add to the subnet"
  default     = null
}
