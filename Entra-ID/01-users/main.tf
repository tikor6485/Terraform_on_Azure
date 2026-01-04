/*
main.tf
- Creates Entra ID users via the azuread provider.
- Safe default: creates nothing unless var.users is provided.
*/

data "azuread_client_config" "current" {}

# Convert list to map keyed by UPN for stable addressing.
locals {
  users_by_upn = {
    for u in var.users : lower(u.user_principal_name) => u
  }
}

resource "azuread_user" "user" {
  for_each = local.users_by_upn

  # Required identity fields
  user_principal_name = each.value.user_principal_name
  display_name        = each.value.display_name

  # mail_nickname is required by Microsoft Graph; must be unique within tenant.
  # Derived from the UPN prefix to keep it deterministic.
  mail_nickname = replace(split("@", each.value.user_principal_name)[0], ".", "-")

  account_enabled = each.value.account_enabled

  # Password fields (NOTE: azuread_user does NOT support password_profile block)
  password              = each.value.password
  force_password_change = each.value.force_change_password_next_sign_in
}
