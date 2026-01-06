output "tenant_id" {
  description = "Entra tenant ID."
  value       = data.azuread_client_config.current.tenant_id
}

output "application_id" {
  description = "Object ID of the Azure AD application."
  value       = azuread_application.app.id
}

output "client_id" {
  description = "Client ID (application ID) used for OAuth/OpenID flows."
  value       = azuread_application.app.client_id
}

output "service_principal_object_id" {
  description = "Object ID of the service principal (Enterprise App)."
  value       = azuread_service_principal.sp.object_id
}

output "client_secret_value" {
  description = "Client secret value (only if create_client_secret=true). Treat as sensitive."
  value       = var.create_client_secret ? azuread_application_password.secret[0].value : null
  sensitive   = true
}

output "client_secret_expires" {
  description = "Client secret expiration time (approx; may be ignored after first apply)."
  value       = var.create_client_secret ? azuread_application_password.secret[0].end_date : null
}
