terraform {
    backend "azurerm" {
        resource_group_name   = "rgxxx"
        storage_account_name  = "stgacnttf"
        container_name        = "tfstate-xxxx"
        key                   = "xxxx.terraform.tfstate"
    }
}
