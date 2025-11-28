environment = "prod"
aks_nodes_address_prefix = "xxx"
app_subnet = "xx"
app_subnet_address_prefix = "xxxx"
private_endpoints = ""
private_endpoints_prefixes = "xxx"
subnet_names          = local.subnet_cidr
subnet_service_endpoints    = ["Microsoft.ContainerRegistry", "Microsoft.KeyVault", "Microsoft.Web"]

storage_conn_string = "xxxxxxxxxxxxxxxxxxxxxxxxx"

access_policy_object_ids = ["xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxx", "xxxxx-xxxx-xxxx-xxxxx-xxxxxxx", "xxxxx-xxxx-xxxxx-xxxx-xxxxx"]

vnet_cidr_address_space = "10.162.0.0/21"
cidr = [
  {
    name              = "webapp_connectivity"
    cidr              = ["10.162.0.0/28"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = ["Microsoft.Sql", "Microsoft.CognitiveServices", "Microsoft.KeyVault", "Microsoft.Storage"]
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
  },
  {
    name              = "pdfconv_slow_subnet"
    cidr              = ["10.162.0.192/27"]
    subnet_delegation = {}
    sku               = null
    service_endpoints = []
  }
]
