locals {
  full_name = trimsuffix(join([var.environment]))
}

resource "azurerm_app_service_plan" "example" {
  count               = var.environment != "prod" ? 1 : 0
  name                = "asp-${local.full_name}"
  location            = var.location
  resource_group_name = module.resource_group_name
  kind                = "Linux"
  reserved            = true
  tags                = merge(var.tags, { service = "asp" })
  sku {
    tier = var.asp_tier
    size = var.asp_size
  }
}

resource "azurerm_app_service" "app_service" {
  count               = var.environment != "prod" ? 1 : 0
  name                = "as-${local.full_name}"
  location            = var.location
  resource_group_name = azurerm.resource_group_name.rg.name
  app_service_plan_id = azurerm_app_service_plan.example[0].id
  tags                = merge(var.tags, { service = "as" })
  site_config {
    linux_fx_version          = "DOTNETCORE|6.0"
    use_32_bit_worker_process = true
    ftps_state                = "FtpsOnly"
    always_on                 = true
  }

  app_settings = {
    "ASPNETCORE_ENVIRONMENT"          = "${lookup(var.environment)}"
    "BlobConnectionString"            = "${var.storage_conn_string}"
    "keyVaultName"                    = "xxxxxx-${var.environment}"
    "TokenKey"                        = "${lookup(var.mock_api_token, var.environment)}"
    "Password"                        = var.password
    "UserId"                          = "mock"
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
  }

  https_only          = true
  client_cert_enabled = false
  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "webapp_connection" {
  count          = var.environment != "prod" ? 1 : 0
  app_service_id = azurerm_app_service.app_service[0].id
  subnet_id      = var.subnet_id
}
