terraform {
  required_version = ">= 1.5.0"

  # Remote backend is configured via: terraform init -backend-config=backend.hcl
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }
  }
}
