terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }
  }
}

# Configure AzureRM provider. When subscription_id is empty, Azure CLI login context is used.
provider "azurerm" {
  features {}

  subscription_id = var.subscription_id != "" ? var.subscription_id : null
}
