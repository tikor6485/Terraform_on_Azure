provider "azurerm" {
  features {}

  # Optional: if empty, Terraform will try Azure CLI / environment variables.
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
  tenant_id       = var.tenant_id != "" ? var.tenant_id : null
}

provider "azuread" {
  # Optional: if empty, provider uses the current Azure CLI / environment context.
  tenant_id = var.tenant_id != "" ? var.tenant_id : null
}
