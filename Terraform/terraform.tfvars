# terraform.tfvars
subscription_id = "your-subscription-id"
tenant_id       = "your-tenant-id"
client_id       = "your-client-id"
client_secret   = "your-client-secret"

project_name    = "prodapp"
environment     = "production"
location        = "uaenorth"
resource_group_name = "rg-prod"

# AKS Configuration
aks_version     = "1.27.3"
aks_node_count  = 3
aks_vm_size     = "Standard_B4ms"

# Network Configuration
vnet_address_space = ["10.0.0.0/16"]