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
  subscription_id = "5988f9e5-eefd-4a23-90ab-33ebf0aa881b"
  tenant_id       = "fd097d1c-865c-4c33-b04a-00e0f0771709"
}
