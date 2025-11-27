variable "tags" {
  description = "Tags to apply to this resource."
  type        = map(string)
}

variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
}

variable "name_suffix" {
  description = "Optional suffix to append to the service bus name."
  type        = string
  default     = ""
}

variable "environment" {
  description = "The environment this service bus is situated within."
  type        = string
}

# ------------- DEPENDENCIES -----------------------

variable "subnet_id" {
  type        = string
  description = "WebApp subnet ID used for connecting azure app service to SQL database"
}

variable "storage_conn_string" {
  type        = string
  description = "Connection string of PhlexVision Storage Account"
}
# ------------- END DEPENDENCIES -------------------#
#------------------CONFIGURATION--------------------#
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
#------------------END CONFIGURATION--------------------#
#-------------------SECRETS-------------------#
variable "mock_api_token" {
  type        = map(string)
  description = "Mock Api Token Map for various environments"
  default = {
    dev = "#{vision-dev-jwt-secret-mock-app}#"
    int = "#{vision-int-jwt-secret-mock-app}#"
    stg = "#{vision-stg-jwt-secret-mock-app}#"
  }
}
variable "identity_ids" {
  description = "The name to give the user assigned managed identity"
  type        = list(string)
  default     = null
}
variable "identity_type" {
  description = "The type of user assigned managed identity"
  type        = string
  default     = null
}

variable "password" {
  description = "Secret for the app setting"
  default     = "#{phlex-mock-secret}#"
}
