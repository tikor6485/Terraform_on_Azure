# Backend Template (Azure Remote State)

This folder is a reusable template you can copy into any Terraform project to enable an Azure Storage remote backend.

It is intentionally minimal and does not contain any secrets or credentials.

## What you get

- `versions.tf`: Terraform + provider version constraints
- `providers.tf`: AzureRM provider config (optionally pins subscription_id)
- `variables.tf`: minimal variables (including subscription_id)
- `backend.hcl.example`: backend configuration file template (Azure Storage)
- `terraform.tfvars.example`: example input values (non-secret)

## How to use in a new project

1) Copy these files into your project root:
- versions.tf
- providers.tf
- variables.tf
- backend.hcl.example
- terraform.tfvars.example

2) Create your real backend config file (do NOT commit it):
- Copy `backend.hcl.example` to `backend.hcl`
- Fill in:
  - resource_group_name
  - storage_account_name
  - container_name
  - key

Important: `key` must be unique per project (and often per environment). Example keys:
- `az-104/05-linux-vm/terraform.tfstate`
- `entra-id/06-app-registrations/terraform.tfstate`
- `az-700/06-private-endpoints-dns/terraform.tfstate`

3) Initialize with backend config:
- Run:
  - terraform init -backend-config=backend.hcl

4) (Optional) Provide variables:
- Use environment variables (recommended for automation), or
- Copy `terraform.tfvars.example` to `terraform.tfvars` (do NOT commit `terraform.tfvars`)

## Authentication (no secrets in code)

This setup expects you to authenticate via Azure CLI:
- az login
- az account set --subscription <SUBSCRIPTION_ID>

Backend auth uses Azure AD (`use_azuread_auth = true`), so ensure your identity has Blob Data Contributor permissions on the state container.

## Purpose
This folder contains template files only. Do not run Terraform here.
