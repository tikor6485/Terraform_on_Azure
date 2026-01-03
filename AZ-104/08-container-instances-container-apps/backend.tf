// Terraform backend definition.
// The real backend settings (RG/SA/container/key) are provided via -backend-config or backend.hcl (DO NOT COMMIT backend.hcl).
terraform {
  backend "azurerm" {}
}
