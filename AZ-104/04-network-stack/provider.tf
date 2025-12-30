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

  # Use TF_VAR_subscription_id (recommended) or terraform.tfvars (local only).
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
}
