
subscription_id  = "xxxxxxxxxxxx"
tenant_id        = "xxxxxxxxxxxx"
client_id        = "xxxxxxxxxxxx"
client_object_id = "xxxxxxxxxxxx"
client_secret    = "xxxxxxxxxxxx"

location              = "uaenorth"
product               = "xxxxxx"
environment           = "prod"


managed_identity_name = "xxxxxxx"
managed_identity_rg   = "xxxxxxxxx"


cluster_node_subnet                   = "10.162.4.0/23"
is_production                         = true
install_keda                          = true
keda_chart_version                    = "2.12.0"
aks_upgrade_hours                     = "18:00"
aks_upgrade_day                       = "Sunday"
enable_auto_upgrades                  = true
enable_auto_scaling                   = false
min_node_count                        = null
max_node_count                        = null
default_configuration_disk_cpu_ration = 5
subnet_names                          = "aks_cluster_node_pool_subnet"


keyvault_name            = "kv"
access_policy_object_ids = ["xxxxxxxxxxxx", "xxxxxxxxxxxx", "xxxxxxxxxxxx"]

vnet_cidr_address_space = "10.162.0.0/21"
cidr = [
  {
    name              = "xxxxxxx"
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
  },
  {
    name              = "pdfconv_subnet"
    cidr              = ["10.162.0.160/27"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = []
  },
  {
    name              = "private_endpoint_subnet"
    cidr              = ["10.162.0.32/27"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.CognitiveServices"]
  }
]
