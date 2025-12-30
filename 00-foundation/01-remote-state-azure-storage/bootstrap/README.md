# Azure Remote State Bootstrap (Azure Storage)

This folder bootstraps the minimum Azure resources required to store Terraform remote state in an Azure Storage Account:

- Resource Group
- Storage Account
- Blob Container
- Minimal RBAC on the container scope:
  - Storage Blob Data Contributor for:
    - the current signed-in identity (from `az login`)
    - any additional principal object IDs you provide

No secrets/credentials are stored in code.

## Prerequisites

- Azure CLI installed and logged in:
  - `az login`
  - Ensure the correct subscription is selected: `az account show`
- Terraform installed

## Quick start

1) (Optional) Set variables via environment variables:

    export TF_VAR_location="northeurope"
    export TF_VAR_environment="dev"
    export TF_VAR_resource_prefix="tfstate-demo"
    export TF_VAR_name_suffix="tirdad"   # recommended to avoid global Storage Account name collisions

2) Initialize and apply:

    terraform init
    terraform fmt
    terraform validate
    terraform plan
    terraform apply

3) Capture outputs (you will use them in your per-project backend config):

    terraform output

## Grant access to additional principals

If you want more identities (e.g., a second laptop user, CI identity, or a teammate) to be able to read/write remote state, provide their Azure AD object IDs via `principal_ids`.

Example using environment variables:

    export TF_VAR_principal_ids='["00000000-0000-0000-0000-000000000000","11111111-1111-1111-1111-111111111111"]'
    terraform apply

Or create a local `terraform.tfvars` (do not commit it) based on `terraform.tfvars.example`.

## Outputs you will need

After apply, note:
- resource_group_name
- storage_account_name
- container_name

You will also get a suggested backend config snippet via output.

## Cleanup

If you no longer need the remote state resources:

    terraform destroy
