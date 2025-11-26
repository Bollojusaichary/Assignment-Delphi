# ---------------- METADATA ------------------------
variable "location" {
  description = "The location/region where the resource group is created."
  type        = string
}

variable "location_abbreviation" {
  description = "The short location name, according to DevOps standards."
  type        = string
}

variable "product" {
  description = "The name of the product this resource group is for."
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
# ------------- END METADATA -----------------------
