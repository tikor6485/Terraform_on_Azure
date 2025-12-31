# ------------------------------------------------------------
# AZ-104 / 02 - Storage Account (reuse RG, standard naming/tags)
# ------------------------------------------------------------

# Reuse the Resource Group from AZ-104/01-resource-group.
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Random suffix to make the Storage Account name globally unique.
resource "random_string" "suffix" {
  length  = 6
  lower   = true
  numeric = true
  special = false
  upper   = false
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                = "${local.storage_account_name_base}${random_string.suffix.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = var.location

  # Production-relevant defaults (basic baseline; can be hardened later in AZ-500).
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  # Ensure you're not accidentally deploying to a different region than the RG.
  lifecycle {
    precondition {
      condition     = var.location == data.azurerm_resource_group.rg.location
      error_message = "location must match the Resource Group location. Set var.location to the RG region."
    }
  }

  tags = local.tags
}

# Optional container (useful for simple labs / app assets).
resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}
