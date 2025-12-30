provider "azurerm" {
  # We intentionally rely on Azure CLI authentication (az login) and the selected subscription context.
  # This keeps the repo free of credentials and avoids hard-coding subscription IDs in code.
  features {}
}
