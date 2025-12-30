locals {
  # Standard reusable name prefix for resources across the repository.
  # Example: "tf-on-azure-dev"
  name_prefix = "${var.project}-${var.environment}"

  # Base tags expected across all stacks/resources.
  base_tags = {
    project     = var.project
    environment = var.environment
    location    = var.location
    owner       = var.owner
    cost_center = var.cost_center
    managed_by  = "terraform"
  }

  # Final tags: base tags + any caller-provided additional tags.
  # Caller keys override base tags if duplicated.
  tags = merge(local.base_tags, var.additional_tags)
}
