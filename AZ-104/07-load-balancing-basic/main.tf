# ------------------------------------------------------------
# Load Balancer (public) + backend pool + probe + rule.
# Backend NIC attachments are optional via var.backend_nics.
# ------------------------------------------------------------


# ------------------------------------------------------------
# Main resources for the basic Load Balancer stack
# ------------------------------------------------------------


data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Public IP for the Load Balancer frontend
resource "azurerm_public_ip" "pip" {
  name                = local.public_ip_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = var.public_ip_sku

  tags = local.tags
}

# Load Balancer
resource "azurerm_lb" "lb" {
  name                = local.lb_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  sku = var.lb_sku

  frontend_ip_configuration {
    name                 = local.fe_name
    public_ip_address_id = azurerm_public_ip.pip.id
  }

  tags = local.tags
}

# Backend pool
resource "azurerm_lb_backend_address_pool" "pool" {
  name            = local.be_pool_name
  loadbalancer_id = azurerm_lb.lb.id
}

# Health probe (TCP by default)
resource "azurerm_lb_probe" "probe" {
  name            = local.probe_name
  loadbalancer_id = azurerm_lb.lb.id

  protocol = var.lb_protocol
  port     = var.probe_port
}

# LB rule (TCP by default)
resource "azurerm_lb_rule" "rule" {
  name            = local.rule_name
  loadbalancer_id = azurerm_lb.lb.id

  protocol                       = var.lb_protocol
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = local.fe_name

  backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool.id]
  probe_id                 = azurerm_lb_probe.probe.id

  # Conservative defaults for AZ-104 labs
  idle_timeout_in_minutes = 4
  floating_ip_enabled     = false
}

# Optional: Associate NIC IP configurations with the backend pool
resource "azurerm_network_interface_backend_address_pool_association" "assoc" {
  for_each = local.backend_nic_map

  network_interface_id    = each.value.nic_id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.pool.id
}