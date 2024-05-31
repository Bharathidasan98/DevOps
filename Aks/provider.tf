terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.105.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = var.var_sub_id
  client_id       = var.var_client_id
  client_secret = var.var_client_secret
  tenant_id     = var.var_tenant_id
  #skip_provider_registration = false
}
