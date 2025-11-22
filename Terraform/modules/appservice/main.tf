resource "azurerm_service_plan" "this" {
  name                = "plan-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "P2v3"
  zone_redundant      = true
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.project_name}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    always_on        = true
    linux_fx_version = "DOTNET|8.0"
    ftps_state       = "Disabled"
    http2_enabled    = true
  }

  https_only = true

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "DOCKER_REGISTRY_SERVER_URL"          = "https://${var.acr_login_server}"
    "DOCKER_REGISTRY_SERVER_USERNAME"     = var.acr_admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD"     = var.acr_admin_password
  }
}