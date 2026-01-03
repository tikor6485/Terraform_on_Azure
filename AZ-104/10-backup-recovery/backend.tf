# Terraform backend definition.
# The actual backend configuration must be provided via a local-only backend.hcl file:
#   terraform init -backend-config=backend.hcl -reconfigure
terraform {
  backend "azurerm" {}
}
