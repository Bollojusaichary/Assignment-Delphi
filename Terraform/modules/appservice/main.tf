locals {
  fullname = "${var.environment}-${var.location}" 

    env = tomap({
    prod = "Production"
  })
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-${local.fullname}"
  location            = var.location
  resource_group_name = module.resource_group.name
  kind                = "Linux"
  tags                = merge({ service = "asp" }, var.environment)
  sku {
    tier = var.asp_tier
    size = var.asp_size
  }
}

resource "azurerm_linux_web_app" "appservice" {
  name                = "appsvc-${local.fullname}"
  resource_group_name = module.resource_group.name
  location            = var.location
  service_plan_id     = azurerm_app_service_plan.asp.id

  site_config {
    always_on         = true
    ftps_state        = "FtpsOnly"
    use_32_bit_worker = false
  }

  app_settings = {
    "BlobConnectionString"     = "${var.storage_conn_string}"
    "keyVaultName"             = module.AKS.name
    "ASPNETCORE_ENVIRONMENT"   = "${lookup(local.env, var.environment)}"
  }

  https_only          = true
  identity {
    type         = var.identity_type
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "appsvc_connection" {
  app_service_id = azurerm_linux_web_app.appservice.id
  subnet_id      = var.subnet_id
}
