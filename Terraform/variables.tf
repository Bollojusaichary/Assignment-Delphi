variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "Azure service principal client ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Azure service principal client secret"
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "Resource_group"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "prodapp"
}

variable "environment" {
  description = "Environment name (dev, staging, production)"
  type        = string
  default     = "production"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "uaenorth"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Project     = "demo-app"
    ManagedBy   = "terraform"
  }
}

# AKS Variables
variable "aks_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.27.3"
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number 
  default     = 3
}

variable "aks_vm_size" {
  description = "AKS node VM size"
  type        = string
  default     = "Standard_B4ms"
}

# Network Variables
variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}