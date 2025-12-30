terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }
  }

  # Backend configuration is provided at init-time:
  # terraform init -backend-config=backend.hcl
  backend "azurerm" {}
}
