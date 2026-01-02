# ------------------------------------------------------------
# Useful outputs for troubleshooting and for downstream stacks.
#
# Outputs: useful for labs and for linking with other stacks
# ------------------------------------------------------------

output "name_prefix" {
  description = "Computed name prefix used across resources."
  value       = local.name_prefix
}

output "tags" {
  description = "Merged tags applied to resources."
  value       = local.tags
}

output "resource_group_name" {
  description = "Resource group used by this stack."
  value       = data.azurerm_resource_group.rg.name
}

output "public_ip_address" {
  description = "Public IP address of the Load Balancer."
  value       = azurerm_public_ip.pip.ip_address
}

output "load_balancer_id" {
  description = "Load Balancer resource ID."
  value       = azurerm_lb.lb.id
}

output "backend_pool_id" {
  description = "Backend address pool ID."
  value       = azurerm_lb_backend_address_pool.pool.id
}
