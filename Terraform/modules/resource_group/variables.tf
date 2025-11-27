variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
}

variable "environment" {
  description = "The environment this resource group is situated within."
  type        = string
}

variable "tags" {
  description = "Tags to apply to this resource."
  type        = map(string)
}
