# Local values to keep naming and tags consistent across stacks.
locals {
  name_prefix = "${var.project}-${var.environment}"

  # Standard tag set used across the repo.
  # Empty strings are converted to null to avoid noisy tags in Azure.
  tags = merge(
    {
      project     = var.project
      environment = var.environment
      managed_by  = "terraform"
      owner       = var.owner != "" ? var.owner : null
      cost_center = var.cost_center != "" ? var.cost_center : null
    },
    var.additional_tags
  )
}
