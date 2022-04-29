terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}

  client_id = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
}