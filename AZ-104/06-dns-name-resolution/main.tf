# ------------------------------------------------------------
# AZ-104 / 06 - DNS Name Resolution (Private DNS Zone)
# Creates: Private DNS Zone + VNet Link (+ optional test A record)
# Reuses:  Resource Group (01) + Virtual Network (03)
# ------------------------------------------------------------

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone" "zone" {
  name                = local.private_dns_zone_name
  resource_group_name = data.azurerm_resource_group.rg.name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "${local.name_prefix}-dns-link"
  resource_group_name   = data.azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.zone.name
  virtual_network_id    = data.azurerm_virtual_network.vnet.id
  registration_enabled  = var.registration_enabled
  tags                  = local.tags
}

resource "azurerm_private_dns_a_record" "test" {
  count               = (trimspace(var.test_a_record_name) != "" && trimspace(var.test_a_record_ip) != "") ? 1 : 0
  name                = var.test_a_record_name
  zone_name           = azurerm_private_dns_zone.zone.name
  resource_group_name = data.azurerm_resource_group.rg.name
  ttl                 = 300
  records             = [var.test_a_record_ip]
  tags                = local.tags
}
