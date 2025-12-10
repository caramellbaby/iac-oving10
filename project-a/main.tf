terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    use_oidc = true
    resource_group_name  = "rg-terraform-backend-pamir"
    storage_account_name = "pamirterraformstate123"
    container_name       = "tfstate"
    key                  = "project_a.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

resource "azurerm_resource_group" "rg_a" {
  name     = "rg-demo-project-a"
  location = "West Europe"
}

resource "azurerm_storage_account" "sa_a" {
  name                     = "sapamira12345"
  resource_group_name      = azurerm_resource_group.rg_a.name
  location                 = azurerm_resource_group.rg_a.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
