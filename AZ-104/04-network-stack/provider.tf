# AzureRM provider.
# Authentication is intentionally left to Azure CLI context (az login),
# or environment variables handled outside of code (e.g., ARM_SUBSCRIPTION_ID).
provider "azurerm" {
  features {}
}
