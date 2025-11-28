variable "location" {
  type = string
  description = "this is prod location."
}

variable "environment" {
  type = string
  description = "this is prod env."
}

variable "allowed_networks" {
  type        = list(string)
  description = "List of Networks/IP's allowed in NSG Service rule"
  default     = ["20.54.34.104", "20.54.222.172", "20.54.98.28", "51.138.8.90", "52.186.47.93", "52.180.99.128", "20.185.14.206", "13.64.27.124"] #TMF AKS EGRESS IP's
}
