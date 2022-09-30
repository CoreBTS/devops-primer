provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-devopsprimer-shared-01"
    storage_account_name = "sttfdevopsprimer01"
    container_name       = "tfstate-amo-sample"
    key                  = "terraform.tfstate"
  }
}

resource "azurerm_resource_group" "example" {
  name     = "rg-example-dev-01"
  location = "eastus2"
}