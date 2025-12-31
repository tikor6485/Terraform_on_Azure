# AzureRM provider.
# Auth is intentionally handled by Azure CLI (az login) or env vars (ARM_SUBSCRIPTION_ID).
provider "azurerm" {
  features {}
}
