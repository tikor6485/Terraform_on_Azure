/*
provider.tf
- Configures providers used by this stack.
- Authentication is expected to be handled via Azure CLI login:
    az login
- Ensure your account has Entra permissions to create users (e.g., User Administrator).
*/

provider "azurerm" {
  features {}
}

provider "azuread" {}
