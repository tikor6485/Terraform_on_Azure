# Terraform settings and provider constraints.
terraform {
  required_version = ">= 1.5.0"

  # Remote backend is configured via backend.hcl (local file, NOT committed).
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }
  }
}
