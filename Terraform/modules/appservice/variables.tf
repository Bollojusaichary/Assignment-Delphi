variable "environment" {
  type = string
  description = "this is prod env."
}

variable "location" {
  type = string
  description = "this is prod location."
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

variable "identity_type" {
  type        = string
  description = "App Service Plan Size."
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "WebApp subnet ID used for connecting azure app service to SQL database"
}
