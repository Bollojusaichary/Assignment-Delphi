terraform {
    backend "azurerm" {
        resource_group_name   = "rgk8s"
        storage_account_name  = "stgacnttf"
        container_name        = "tfstate-appservice"
        key                   = "appservice.terraform.tfstate"
    }
}