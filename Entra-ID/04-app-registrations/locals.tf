locals {
  name_prefix = "${var.project}-${var.environment}"

  # Deterministic default naming if user doesn't change app_display_name
  effective_app_display_name = (
    var.app_display_name != "" ? var.app_display_name : "${local.name_prefix}-app"
  )
}
