terraform {
  # Backend config is intentionally kept minimal in code.
  # Use a local file `backend.hcl` (NOT committed) during `terraform init`.
  backend "azurerm" {}
}
