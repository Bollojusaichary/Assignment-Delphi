variable "product" {
  description = "The name of the product this service bus is for."
  default     = "delphi"
}

variable "tags" {
  description = "Tags to apply to this resource."
  default        = "prod"
}

variable "subnet_name" {
  type        = string
  description = "Specifies the name for the network subnet"
  default     = "xxxxxx"
}

variable "subnet_name" {
  type        = string
  description = "Specifies the name for the network subnet"
  default     = "xxxxxxx"
}

variable "location" {
  description = "The location/region where the service bus is created."
  default     = "uaenorth"
}

variable "vnet_address_space" {
  description = "The network address space of this VNet."
  type        = list(string)
  default     = "xxxxx" 
}

variable "location_abbreviation" {
  description = "The short location name, according to DevOps standards."
  default     = "uaenorth"
}

variable "environment" {
  description = "The environment this service bus is situated within."
  type        = string
}
variable "subscription_id" {
  description = "Azure Subscription ID for PhlexVision"
  type        = string
  default     = "f0d3757c-9b40-43d3-ba6b-e3be083b0dd3"
}

variable "tenant_id" {
  description = "Azure Tenant ID for PhlexVision"
  type        = string
  default     = "xxxxxxx"
}

variable "client_id" {
  description = "Client ID/App ID for associated subscription (Terraform SP)"
  type        = string
  default     = "xxxxxxx"
}

variable "client_object_id" {
  description = "Object ID of the above app (Terraform SP)"
  type        = string
  default     = "xxxxxxxx"
}

variable "client_secret" {
  description = "Secret for the above app (Terraform SP)"
  type        = string
  default     = "xxxxxxxxx"
}
