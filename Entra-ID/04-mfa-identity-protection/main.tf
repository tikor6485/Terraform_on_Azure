data "azuread_client_config" "current" {}

# Look up target groups only when CA creation is enabled.
data "azuread_group" "included" {
  for_each     = local.included_groups_map
  display_name = each.value
}

# Look up excluded users only when CA creation is enabled.
data "azuread_user" "excluded" {
  for_each            = local.excluded_users_map
  user_principal_name = each.value
}

resource "azuread_conditional_access_policy" "require_mfa" {
  count        = var.enable_conditional_access ? 1 : 0
  display_name = local.effective_policy_display_name
  state        = var.policy_state

  conditions {
    # Users/groups in scope
    users {
      included_groups = [
        for g in data.azuread_group.included : g.object_id
      ]

      excluded_users = [
        for u in data.azuread_user.excluded : u.object_id
      ]
    }

    # Target all cloud apps by default.
    applications {
      included_applications = ["All"]
    }

    # Cover interactive sign-ins broadly.
    client_app_types = ["all"]
  }

  grant_controls {
    operator          = "OR"
    built_in_controls = ["mfa"]
  }
}
