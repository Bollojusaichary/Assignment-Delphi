variable "environment" {
  type = string
  description = "this is prod env."
}

variable "location" {
  type = string
  description = "this is prod location."
}

variable "vnet_address_space" {
  type = list(string)
  description = "this is prod vnet address space."
}
