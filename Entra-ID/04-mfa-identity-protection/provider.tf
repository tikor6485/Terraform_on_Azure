provider "azurerm" {
  features {}
}

provider "azuread" {
  # Uses Azure CLI / current identity by default.
}
