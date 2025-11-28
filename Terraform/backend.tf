terraform {
  backend "azurerm" {
    resource_group_name    = "xxxxxxx"
    storage_account_name   = "xxxxxx"
    container_name         = "xxxxxxx"
    key                    = "xxxxxxx"
  }
}
