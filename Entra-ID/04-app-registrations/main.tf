data "azuread_client_config" "current" {}

# App Registration (Application)
resource "azuread_application" "app" {
  display_name     = local.effective_app_display_name
  sign_in_audience = var.sign_in_audience

  # Owners: if provided, use them; otherwise set current caller as owner
  owners = length(var.owners_object_ids) > 0 ? var.owners_object_ids : [data.azuread_client_config.current.object_id]
}

# Enterprise App (Service Principal)
resource "azuread_service_principal" "sp" {
  client_id = azuread_application.app.client_id

  owners = length(var.owners_object_ids) > 0 ? var.owners_object_ids : [data.azuread_client_config.current.object_id]
}

# Optional: Client secret
resource "azuread_application_password" "secret" {
  count          = var.create_client_secret ? 1 : 0
  application_id = azuread_application.app.id

  display_name = var.client_secret_display_name
  end_date     = timeadd(timestamp(), "${var.client_secret_validity_hours}h")

  # Prevent endless diffs due to timestamp drift:
  lifecycle {
    ignore_changes = [end_date]
  }
}
