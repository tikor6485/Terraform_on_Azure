# Entra-ID / 03 - Azure RBAC at Resource Group Scope

Creates Azure RBAC role assignments (AzureRM) at a Resource Group scope.
Principals are resolved from Entra ID (AzureAD) by either:
- user UPN, or
- group display name, or
- direct principal object id.

## Reuses
- Resource Group created by `AZ-104/01-resource-group`
- Users/Groups created by:
  - `Entra-ID/01-users`
  - `Entra-ID/02-groups`

## What it creates
- Role assignments (`azurerm_role_assignment`) at the scope of one Resource Group

## Run
1) Backend config:
- `cp backend.hcl.example backend.hcl` (edit values, especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide scope dependency:
- `export TF_VAR_resource_group_name="az-104-dev-rg"`
  (or load it from your RG stack output if you prefer)

4) Provide RBAC assignments:
- `cp terraform.tfvars.example terraform.tfvars`
- Edit `terraform.tfvars` as needed.

5) Plan/Apply:
- `terraform plan`
- `terraform apply`

## Notes
- This stack resolves principals via the AzureAD provider:
  - `user_upn` uses `data.azuread_user`
  - `group_display_name` uses `data.azuread_group`
- If your tenant contains multiple groups with the same display name, prefer using `principal_object_id` instead.

## Clean up
- `terraform destroy`

## Git hygiene
Do NOT commit:
- `backend.hcl`
- `.terraform/`
- `terraform.tfstate*`

Keep:
- `backend.hcl.example`
- `.terraform.lock.hcl`
