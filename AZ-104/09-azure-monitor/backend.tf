# Configures Terraform to store state in an Azure Storage Account (Remote State).
# The actual backend settings (RG/SA/container/key) are supplied via backend.hcl at init time.
terraform {
  backend "azurerm" {}
}
