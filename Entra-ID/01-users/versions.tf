/*
versions.tf
- Locks Terraform and provider versions for consistent, reproducible runs.
- This stack uses:
  - azurerm: only for remote state backend compatibility and consistency with other stacks
  - azuread: to manage Microsoft Entra ID (Azure AD) objects
*/

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 2.40.0, < 3.0.0"
    }
  }
}
