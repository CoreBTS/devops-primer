provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devopsprimer-shared-01"
    storage_account_name = "sttfdevopsprimer01"
    container_name       = "tfstate-amo-test"
    key                  = "terraform.tfstate"
  }
}