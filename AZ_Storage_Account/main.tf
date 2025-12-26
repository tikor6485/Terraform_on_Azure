locals {
  tags = {
    demo        = "az-storage-account"
    environment = var.environment
    managed_by  = "terraform"
  }

  rg_name = "${var.resource_prefix}-${var.environment}-rg"
}

resource "azurerm_resource_group" "tirdad" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

resource "random_string" "tirdad" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

# Storage account names must be globally unique, 3-24 chars, lowercase letters and numbers only.
resource "azurerm_storage_account" "tirdad" {
  name                     = "${replace(var.resource_prefix, "-", "")}${var.environment}${random_string.tirdad.result}"
  resource_group_name      = azurerm_resource_group.tirdad.name
  location                 = azurerm_resource_group.tirdad.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = local.tags
}

resource "azurerm_storage_container" "tirdad" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.tirdad.id
  container_access_type = "private"
}
