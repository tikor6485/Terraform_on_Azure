data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azuread_client_config" "current" {}

# Resolve users by UPN (when provided).
data "azuread_user" "by_upn" {
  for_each            = local.assignments_by_upn
  user_principal_name = trimspace(each.value.user_upn)
}

# Resolve groups by display name (when provided).
data "azuread_group" "by_display_name" {
  for_each     = local.assignments_by_group_name
  display_name = trimspace(each.value.group_display_name)
}

# Create role assignments at RG scope.
resource "azurerm_role_assignment" "rg" {
  for_each = {
    for a in var.assignments : a.key => a
  }

  scope                = data.azurerm_resource_group.rg.id
  role_definition_name = trimspace(each.value.role_name)

  # Determine principal_id based on the selector.
  principal_id = (
    try(each.value.principal_object_id, null) != null ? trimspace(each.value.principal_object_id) :
    try(each.value.user_upn, null) != null ? data.azuread_user.by_upn[each.key].object_id :
    data.azuread_group.by_display_name[each.key].object_id
  )

  skip_service_principal_aad_check = try(each.value.skip_service_principal_aad_check, false)
}
