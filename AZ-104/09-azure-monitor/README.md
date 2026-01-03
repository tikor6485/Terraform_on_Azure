# AZ-104 / 09 - Azure Monitor (Log Analytics + optional Application Insights + optional Diagnostics)

This stack provisions a **Log Analytics Workspace** for centralized logging/monitoring.
Optionally, it can also create **Application Insights (workspace-based)** and attach an **Azure Monitor Diagnostic Setting**
to any Azure resource you choose (VM, Load Balancer, Storage Account, Container Group, etc.).

## Reuses
- Resource Group created by `AZ-104/01-resource-group`

## What it creates
- Log Analytics Workspace
- (Optional) Application Insights (workspace-based)
- (Optional) Diagnostic Setting attached to a target resource

## Notes
- Diagnostic Settings require you to provide a **target resource ID** and the **log/metric categories** supported by that resource.
  Categories differ per resource type.
- If you do not provide a target resource ID, the stack will still create the Log Analytics Workspace (and optional App Insights).

## Run

### 1) Backend config
- `cp backend.hcl.example backend.hcl`
- Edit values (especially `key`)

### 2) Init
- `terraform init -backend-config=backend.hcl -reconfigure`

### 3) Provide dependencies (example)
- `export TF_VAR_resource_group_name="$(cd ../01-resource-group && terraform output -raw resource_group_name)"`

### 4) Optional: enable diagnostics for a resource
Provide the target resource ID and categories, e.g.:
- `export TF_VAR_diag_target_resource_id="/subscriptions/<sub>/resourceGroups/<rg>/providers/<RP>/<type>/<name>"`
- `export TF_VAR_diag_log_categories='["Administrative","Security","ServiceHealth","Alert","Recommendation","Policy","Autoscale","ResourceHealth"]'`
- `export TF_VAR_diag_metric_categories='["AllMetrics"]'`

(Those categories are only examples; use categories supported by your chosen resource.)

### 5) Plan / Apply
- `terraform plan`
- `terraform apply`

## Clean up
- `terraform destroy`

## Git hygiene
Do NOT commit:
- `backend.hcl`
- `.terraform/`
- `terraform.tfstate*`

Commit:
- `.terraform.lock.hcl`
- `backend.hcl.example`
- `*.tf`
- `terraform.tfvars.example`
- `README.md`
