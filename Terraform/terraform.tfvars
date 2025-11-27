
subscription_id       = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
tenant_id             = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
client_id             = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
client_object_id      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
client_secret         = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx"
location              = "uaenorth"
environment           = "production"
tags                  = "prod"


cluster_node_subnet                   = "10.162.4.0/23"

vnet_cidr_address_space = "10.162.0.0/21" {
  cidr  {
    name              = "xxxxx"
    cidr              = ["10.162.0.0/28"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = ["Microsoft.KeyVault"]
    subnet_delegation = {
      app_service_plan = [
        {
          name    = "Microsoft.Web/serverFarms"
          actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
        }
      ]
     }
    }
  {
    name              = "xxxxxx"
    cidr              = ["10.162.0.160/27"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = []
  },
  {
    name              = "xxxxxxxxxxxxxxx"
    cidr              = ["10.162.0.32/27"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.CognitiveServices"]
  }
  }
