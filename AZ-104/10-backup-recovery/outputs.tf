output "name_prefix" {
  description = "Common name prefix used by this stack."
  value       = local.name_prefix
}

output "resource_group_name" {
  description = "Resource Group used by this stack."
  value       = data.azurerm_resource_group.rg.name
}

output "tags" {
  description = "Tags applied to resources."
  value       = local.tags
}

output "recovery_services_vault_id" {
  description = "Resource ID of the Recovery Services Vault."
  value       = azurerm_recovery_services_vault.vault.id
}

output "recovery_services_vault_name" {
  description = "Name of the Recovery Services Vault."
  value       = azurerm_recovery_services_vault.vault.name
}

output "vm_backup_policy_id" {
  description = "Resource ID of the VM backup policy."
  value       = azurerm_backup_policy_vm.vm.id
}

output "protected_vm_id" {
  description = "Resource ID of the protected VM backup item (only when enable_vm_protection=true)."
  value       = var.enable_vm_protection ? azurerm_backup_protected_vm.protected[0].id : null
}
