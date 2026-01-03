// Outputs for easy cross-stack reuse and quick verification.

output "name_prefix" {
  description = "Standard name prefix for this stack."
  value       = local.name_prefix
}

output "resource_group_name" {
  description = "Resource Group used by this stack."
  value       = data.azurerm_resource_group.rg.name
}

output "aci_id" {
  description = "Resource ID of the Container Group."
  value       = azurerm_container_group.aci.id
}

output "aci_ip_address" {
  description = "Public IP address of the Container Group."
  value       = azurerm_container_group.aci.ip_address
}

output "aci_fqdn" {
  description = "Public FQDN of the Container Group (only if dns_name_label is set)."
  value       = azurerm_container_group.aci.fqdn
}
