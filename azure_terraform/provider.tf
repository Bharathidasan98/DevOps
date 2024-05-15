terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.91.0"
    }
  }
}
provider "azurerm" {
  features {}
#  subscription_id = "xx"
#  client_id       = "xx"
#  #client_secret = "xx"
#  client_secret = "xx"
#  tenant_id     = "xx"
  #skip_provider_registration = false
}