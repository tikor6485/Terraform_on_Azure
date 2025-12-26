terraform {
  required_version = ">= 1.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }
  }
}

provider "azurerm" {
  features {}

  # Optional: if unset, Azure CLI auth (az login) can be used locally.
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
  tenant_id       = var.tenant_id != "" ? var.tenant_id : null
  client_id       = var.client_id != "" ? var.client_id : null
  client_secret   = var.client_secret != "" ? var.client_secret : null
}
