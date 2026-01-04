/*
backend.tf
- Declares an Azure Storage backend.
- The actual backend settings are injected via backend.hcl (not committed).
*/

terraform {
  backend "azurerm" {}
}
