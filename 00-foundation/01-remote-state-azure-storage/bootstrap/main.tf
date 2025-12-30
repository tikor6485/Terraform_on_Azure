# =========================================================
# main.tf
# Bootstrap Remote State on Azure Storage:
# - Resource Group
# - Storage Account (secure defaults)
# - Private Blob Container for Terraform state
# - RBAC: "Storage Blob Data Contributor" on the container scope
#
# Notes:
# - No secrets/credentials are stored in code.
# - Authentication uses your current Azure CLI session (az login).
# - Storage account naming is deterministic and compliant (3-24 chars, lowercase+digits).
# - RBAC is granted to the current signed-in identity PLUS any extra principal IDs you provide.
# =========================================================

locals {
  # Base prefix used for names. If name_suffix is set, it is appended to avoid collisions.
  base_prefix = var.name_suffix != "" ? "${var.resource_prefix}-${var.name_suffix}" : var.resource_prefix

  # Resource group name: flexible rules, hyphens allowed.
  rg_name = "${local.base_prefix}-${var.environment}-rg"

  # Storage account naming rules:
  # - 3 to 24 characters
  # - lowercase letters and digits only
  #
  # Strategy:
  # - Build a raw name from prefix+env+suffix
  # - Normalize to lowercase
  # - Remove hyphens and any non [0-9a-z]
  # - Trim to 24 chars max
  #
  # This is deterministic (no random provider) to keep bootstrap predictable.
  storage_account_name_raw = lower(replace("${local.base_prefix}${var.environment}sa", "-", ""))
  storage_account_name     = substr(replace(local.storage_account_name_raw, "/[^0-9a-z]/", ""), 0, 24)

  # Common tags applied to all resources created by this bootstrap.
  tags = merge(
    {
      environment = var.environment
      managed_by  = "terraform"
      purpose     = "remote-state"
    },
    var.tags
  )

  # The ARM scope for the blob container, used for RBAC role assignment.
  # We build it from the storage account ID and the container name to avoid
  # relying on deprecated container attributes.
  container_arm_scope = "${azurerm_storage_account.sa.id}/blobServices/default/containers/${var.container_name}"
}

# ---------------------------------------------------------
# Resource Group
# ---------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

# ---------------------------------------------------------
# Storage Account (Remote State)
# ---------------------------------------------------------
resource "azurerm_storage_account" "sa" {
  name                = local.storage_account_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  access_tier              = "Hot"

  # Security-focused defaults
  min_tls_version                  = "TLS1_2"
  https_traffic_only_enabled       = true
  allow_nested_items_to_be_public  = false
  cross_tenant_replication_enabled = false

  # Keep SAS keys enabled for compatibility unless your org requires disabling them.
  # (When using AzureAD auth for the backend, Terraform can work without access keys,
  # but some workflows/tools might still rely on keys.)
  shared_access_key_enabled = true

  # Public network access is left enabled for simplicity in bootstrap.
  # In a hardened setup you may restrict via network_rules / private endpoints later.
  public_network_access_enabled = true

  blob_properties {
    # Helpful for state safety: enables blob versioning.
    versioning_enabled = true
  }

  tags = local.tags
}

# ---------------------------------------------------------
# Blob Container for tfstate
# ---------------------------------------------------------
resource "azurerm_storage_container" "state" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

# ---------------------------------------------------------
# RBAC: grant access to write/read state blobs
# ---------------------------------------------------------
data "azurerm_client_config" "current" {}

locals {
  # Always include the current caller (your az login identity),
  # plus any additional principals you want to authorize.
  #
  # principal_ids examples:
  # - Another user object ID
  # - A service principal object ID (CI/CD)
  # - A managed identity object ID
  state_principal_ids = distinct(concat([data.azurerm_client_config.current.object_id], var.principal_ids))
}

resource "azurerm_role_assignment" "tf_state_blob_data_contributor" {
  for_each             = toset(local.state_principal_ids)
  scope                = local.container_arm_scope
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}
