# Lookup the existing Resource Group (created by AZ-104/01-resource-group).
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Recovery Services Vault for Azure Backup / Recovery.
resource "azurerm_recovery_services_vault" "vault" {
  name                = "${local.name_prefix}-rsv"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku = var.vault_sku

  # Soft delete helps protect against accidental deletion of backup data.
  soft_delete_enabled = var.soft_delete_enabled

  tags = local.tags
}

# VM Backup Policy (Daily).
# This creates the policy only; it does not protect any VM unless enable_vm_protection=true.
resource "azurerm_backup_policy_vm" "vm" {
  name                = "${local.name_prefix}-vm-backup-policy"
  resource_group_name = data.azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  timezone = var.backup_timezone

  backup {
    frequency = "Daily"
    time      = var.backup_time
  }

  retention_daily {
    count = var.retention_daily_count
  }

  retention_weekly {
    count    = var.retention_weekly_count
    weekdays = var.retention_weekly_weekdays
  }
}

# Optional: Enable backup protection for a VM.
# Provide source_vm_id and set enable_vm_protection=true.
resource "azurerm_backup_protected_vm" "protected" {
  count = var.enable_vm_protection ? 1 : 0

  resource_group_name = data.azurerm_resource_group.rg.name
  recovery_vault_name = azurerm_recovery_services_vault.vault.name

  source_vm_id     = var.source_vm_id
  backup_policy_id = azurerm_backup_policy_vm.vm.id
}
