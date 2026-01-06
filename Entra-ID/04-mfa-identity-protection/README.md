# Entra ID - 04 - MFA / Conditional Access (Lab)

This stack can create a Conditional Access policy that **requires MFA** for selected Entra ID security groups.

Why is it optional?
- Conditional Access typically requires **Entra ID P1** (or higher) and specific admin roles.
- To keep the stack runnable in tenants without CA licensing, policy creation is **disabled by default**.

## What this stack does
- (Optional) Creates a Conditional Access policy:
  - Targets one or more groups (by display name).
  - Requires MFA to sign in.
  - Can be set to Report-only or Enabled.

## Prerequisites
- Azure CLI authenticated: `az login`
- You have permissions to manage Entra ID Conditional Access (e.g., Conditional Access Administrator / Global Administrator).
- Entra ID P1+ license if you want to enable policy creation.

## Variables (important)
- `enable_conditional_access` (bool)
  - Default: `false`
  - When `false`, this stack will create **no** Conditional Access resources (safe for any tenant).
- `policy_state` (string)
  - Suggested values:
    - `enabledForReportingButNotEnforced` (Report-only)
    - `enabled`
- `include_group_display_names` (list(string))
  - Group display names to include in the policy scope.
- `exclude_user_upns` (list(string))
  - UPNs to exclude (break-glass accounts recommended).


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
- Default is safe: enable_conditional_access = false (no policy created).
- If you enable it, consider using policy_state = "enabledForReportingButNotEnforced" first (Report-only).
- This stack looks up groups/users by display name / UPN only when CA is enabled.

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
