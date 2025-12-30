# Creates an Azure Resource Group to keep all demo resources organized and easy to clean up.
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}-${var.environment}-rg"
  location = var.location

  tags = {
    demo        = "az-storage-account"
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Generates a short suffix so the storage account name can be globally unique.
resource "random_string" "suffix" {
  length  = 6
  lower   = true
  numeric = true
  special = false
  upper   = false
}

# Creates a Storage Account (name must be globally unique, 3-24 chars, lowercase letters and numbers only).
resource "azurerm_storage_account" "sa" {
  # Remove hyphens to satisfy naming rules (only lowercase letters and numbers).
  name                     = "${replace(var.resource_prefix, "-", "")}${var.environment}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    demo        = "az-storage-account"
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Creates a private Blob Container inside the Storage Account.
resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}
