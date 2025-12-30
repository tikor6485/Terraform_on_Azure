output "resource_group_name" {
  description = "Resource group name for remote state."
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Storage account name for remote state."
  value       = azurerm_storage_account.sa.name
}

output "container_name" {
  description = "Blob container name for remote state."
  value       = azurerm_storage_container.state.name
}

output "backend_hcl_suggestion" {
  description = "Example backend.hcl values you can copy into a per-project backend configuration file."
  value       = <<EOT
resource_group_name  = "${azurerm_resource_group.rg.name}"
storage_account_name = "${azurerm_storage_account.sa.name}"
container_name       = "${azurerm_storage_container.state.name}"
use_azuread_auth     = true

# key must be unique per project (and ideally per environment), e.g.:
# key = "az-104/05-linux-vm/dev.tfstate"
key = "path/to/project.tfstate"
EOT
}
