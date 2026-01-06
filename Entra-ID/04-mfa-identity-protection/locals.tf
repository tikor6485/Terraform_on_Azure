locals {
  name_prefix = "${var.project}-${var.environment}"

  effective_policy_display_name = (
    length(trimspace(var.policy_display_name)) > 0
    ? trimspace(var.policy_display_name)
    : "${local.name_prefix}-require-mfa"
  )

  # Prevent data lookups unless the feature is enabled (avoids errors in tenants without CA setup).
  included_groups_map = var.enable_conditional_access ? {
    for dn in var.included_group_display_names :
    dn => dn if length(trimspace(dn)) > 0
  } : {}

  excluded_users_map = var.enable_conditional_access ? {
    for upn in var.excluded_user_upns :
    upn => upn if length(trimspace(upn)) > 0
  } : {}
}
