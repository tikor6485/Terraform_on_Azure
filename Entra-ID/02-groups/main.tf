data "azuread_client_config" "current" {}

# Create Entra ID security groups.
resource "azuread_group" "group" {
  for_each = local.groups

  display_name = each.value.display_name
  description  = each.value.description

  # Security group settings:
  security_enabled = true
  mail_enabled     = false
  mail_nickname    = each.value.mail_nickname

  # Owners:
  # If the caller did not specify owners, default to the current principal.
  owners = (
    length(each.value.owners_object_ids) > 0
    ? each.value.owners_object_ids
    : [data.azuread_client_config.current.object_id]
  )

  # Optional members (object IDs).
  members = each.value.members_object_ids
}
