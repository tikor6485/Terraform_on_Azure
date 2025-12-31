output "resource_group_name" {
  value = data.azurerm_resource_group.rg.name
}

output "location" {
  value = var.location
}

output "name_prefix" {
  value = local.name_prefix
}

output "tags" {
  value = local.tags
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "nic_id" {
  value = data.azurerm_network_interface.nic.id
}

output "private_ip_address" {
  value = try(data.azurerm_network_interface.nic.ip_configuration[0].private_ip_address, null)
}

output "public_ip_address" {
  value = data.azurerm_public_ip.pip.ip_address
}

output "ssh_command" {
  value = "ssh ${var.admin_username}@${data.azurerm_public_ip.pip.ip_address}"
}
