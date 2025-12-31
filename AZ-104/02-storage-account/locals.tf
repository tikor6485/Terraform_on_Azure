# Standard naming + tagging (same idea as 01-resource-group).

locals {
  # Shared prefix used across this AZ-104 track.
  name_prefix = "${var.project}-${var.environment}"

  # Storage account naming rules:
  # - 3-24 chars
  # - lowercase letters and digits only
  # We keep it simple and deterministic for the base, then add random suffix for global uniqueness.
  # We also limit the base to 18 chars to leave room for a 6-char suffix => max 24 chars.
  storage_account_name_base = substr(lower(replace("${var.project}${var.environment}sa", "-", "")), 0, 18)

  tags_base = {
    project     = var.project
    environment = var.environment
    owner       = var.owner
    cost_center = var.cost_center
    managed_by  = "terraform"
  }

  tags = merge(local.tags_base, var.additional_tags)
}
