variable "project_name" { 
  type = string 
}

variable "environment" { 
  type = string 
}

variable "location" { 
  type = string 
}

variable "product" {
  description = "The name of the product this service bus is for."
  type        = string
}

variable "resource_group_name" { 
  type = string 
}

variable "aks_kubelet_identity_id" { 
  type = string 
}
