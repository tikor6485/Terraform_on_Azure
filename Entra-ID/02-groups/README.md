# Entra ID / 02 - Groups

Creates Microsoft Entra ID security groups using the `azuread` Terraform provider.

This stack is designed to be safe to share on GitHub:
- Do NOT commit `backend.hcl` (local backend config).
- Do NOT commit `.terraform/` or any `terraform.tfstate*`.

## What it creates
- One or more Entra ID security groups (Azure AD groups)

## Inputs
Groups are defined via `var.groups`:
- `display_name` (required)
- `description` (optional)
- `owners_object_ids` (optional; defaults to current principal if empty)
- `members_object_ids` (optional)
- `mail_nickname` (optional; auto-generated if omitted)

## Run

1) Backend config (local only):
- `cp backend.hcl.example backend.hcl`
- Edit values if needed (especially `key`)

2) Init:
- `terraform init -backend-config=backend.hcl -reconfigure`

3) Provide groups:
- `cp terraform.tfvars.example terraform.tfvars`
- Edit `terraform.tfvars` and set `groups`

4) Plan/Apply:
- `terraform fmt`
- `terraform validate`
- `terraform plan`
- `terraform apply`

## Clean up
- `terraform destroy`

## Notes
- If you plan to add members from users created in `Entra-ID/01-users`, prefer using **object IDs**.
- To avoid destroy-order issues, destroy groups before deleting referenced users.
