variable "tags" {
  description = "Tags to apply to this resource."
  type        = string
}

variable "subnet_name" {
  type        = map(string)
  description = "Specifies the name for the aks subnet"
}

variable "cluster_node_subnet" {
  type        = string
  description = "Specifies the name for the network subnet"
}

variable "location" {
  description = "The location/region where the service bus is created."
  type        = string
}

variable "vnet_cidr_address_space" {
  description = "The network address space of this VNet."
  type        = list(string)
}

variable "environment" {
  description = "The environment this service bus is situated within."
  type        = string
}
variable "subscription_id" {
  description = "Azure Subscription ID for PhlexVision"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID for PhlexVision"
  type        = string
}

variable "client_id" {
  description = "Client ID/App ID for associated subscription (Terraform SP)"
  type        = string
}

variable "client_object_id" {
  description = "Object ID of the above app (Terraform SP)"
  type        = string
}

variable "client_secret" {
  description = "Secret for the above app (Terraform SP)"
  type        = string
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
