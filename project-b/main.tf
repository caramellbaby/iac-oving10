terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend-pamir"
    storage_account_name = "pamirterraformstate123"
    container_name       = "tfstate"
    key                  = "project_b.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "7a3c6854-0fe1-42eb-b5b9-800af1e53d70"
}

resource "azurerm_resource_group" "rg_b" {
  name     = "rg-demo-project-b"
  location = "West Europe"
}

resource "azurerm_storage_account" "sa_b" {
  name                     = "sapamira12345"
  resource_group_name      = azurerm_resource_group.rg_b.name
  location                 = azurerm_resource_group.rg_b.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
