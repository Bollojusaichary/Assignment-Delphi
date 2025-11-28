variable "location" {
  type = string
  description = "this is prod location."
}

variable "tenant_id" {
  type = string
  description = "this is prod tenant id."
}

variable "environment" {
  type = string
  description = "this is prod env."
}

variable "purge_protection_enabled" {
  type = string
  description = "this is prod env."
}

variable "client_object_id" {
  type = string
  description = "this is prod env."
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

variable "pe_subnet_id" {
  type        = string
  description = "Subnet to attach Private Endpoint to"
  default     = null
}
