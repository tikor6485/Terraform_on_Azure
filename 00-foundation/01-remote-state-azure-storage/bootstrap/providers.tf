provider "azurerm" {
  features {}

  # If set, Terraform uses this subscription explicitly; otherwise Azure CLI context is used.
  subscription_id = var.subscription_id != "" ? var.subscription_id : null
}
