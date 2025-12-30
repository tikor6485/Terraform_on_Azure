output "name_prefix" {
  description = "Standard name prefix to use across resources (e.g., project-environment)."
  value       = local.name_prefix
}

output "tags" {
  description = "Final merged tags map to apply to resources."
  value       = local.tags
}
