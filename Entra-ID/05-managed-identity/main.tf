# -------------------------
# Scope: existing Resource Group
# -------------------------
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# -------------------------
# User Assigned Managed Identity (UAMI)
# -------------------------
resource "azurerm_user_assigned_identity" "uami" {
  name                = var.managed_identity_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = local.tags
}

# -------------------------
# RBAC: assign built-in role to the UAMI at RG scope
# -------------------------
resource "azurerm_role_assignment" "uami_rg_role" {
  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = var.role_definition_name
  principal_id         = azurerm_user_assigned_identity.uami.principal_id

  # If AAD propagation is slow, this can help avoid intermittent failures.
  # skip_service_principal_aad_check = true
}