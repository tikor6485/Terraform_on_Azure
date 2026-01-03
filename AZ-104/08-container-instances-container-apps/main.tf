// Creates a basic Azure Container Instances (ACI) container group with a public IP.
// Uses a Microsoft public image by default to avoid Docker Hub reliability/rate-limit issues.

data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_container_group" "aci" {
  name                = local.container_group_name
  location            = var.location
  resource_group_name = data.azurerm_resource_group.rg.name

  # Public IP makes it easy to test quickly.
  ip_address_type = "Public"
  os_type         = "Linux"
  restart_policy  = var.restart_policy
  sku             = "Standard"

  # Optional FQDN. If not set, the deployment still works and you can test via public IP.
  dns_name_label              = local.effective_dns_name_label
  dns_name_label_reuse_policy = local.effective_dns_name_label != null ? "Unsecure" : null

  tags = local.tags

  container {
    name   = "app"
    image  = var.container_image
    cpu    = var.container_cpu
    memory = var.container_memory

    ports {
      port     = var.container_port
      protocol = "TCP"
    }
  }
}
