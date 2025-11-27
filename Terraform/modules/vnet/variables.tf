variable "location" {
  description = "The location/region where the VNet is created."
  type        = string
}

variable "environment" {
  description = "The environment this VNet resides within."
  type        = string
}

variable "tags" {
  description = "Tags to apply to this resource."
  type        = map(string)
}

variable "vnet_cidr_address_space" {
  description = "The network address space of this VNet."
  type        = string
}
