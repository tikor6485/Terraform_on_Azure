# Terraform-on-Azure

A practical, portfolio-ready Azure infrastructure repository built with Terraform.
The goal is to keep each lab/demo self-contained, repeatable, and easy to reuse in real projects.

## Repository layout

- `.github/workflows/terraform-ci.yml`
  - CI checks for formatting and validation across Terraform folders.
  - Optional manual plan for a single directory.

- `scripts/`
  - Helper scripts to run Terraform commands consistently across multiple directories.

- `00-foundation/`
  - Shared foundations such as remote state bootstrap and backend templates.

- `az-104/`, `entra-id/`, `az-700/`, `az-500/`, `az-305/`
  - Practical labs grouped by exam domains (Azure operations, identity, networking, security, architecture).

## Core principles

- No secrets or credentials committed to Git.
- Remote state is supported via Azure Storage (bootstrap + backend template).
- Each folder should be runnable independently:
  - `terraform init`
  - `terraform plan`
  - `terraform apply`
  - `terraform destroy`

## Prerequisites

- Azure CLI installed and authenticated:
  - Run `az login`
  - Confirm your subscription: `az account show`
- Terraform installed (match the version used by CI if possible).
- An Azure subscription with permissions to create resources.

## Remote state (recommended)

This repository is designed to use Azure Storage as the remote backend.

Typical flow:
1) Run the remote-state bootstrap once (per subscription/tenant as needed).
2) For each Terraform project folder, use a per-project backend key.

Important:
- The backend key must be unique per project/folder.
  Example: `az-104/05-linux-vm/terraform.tfstate`

## CI workflow

The CI workflow runs:
- `terraform fmt -check -recursive`
- `terraform validate` per Terraform directory (using `init -backend=false`)

A manual `plan` job is also available, intended to run on ONE folder at a time.
For manual plan, the workflow expects Azure authentication via OIDC and (optionally) backend variables.

## How to run a folder locally

1) Enter the folder you want:
- Example: `cd az-104/05-linux-vm`

2) Initialize:
- If using remote backend, ensure you have a `backend.hcl` locally (not committed).
- Otherwise, you can initialize without backend for quick validation.

3) Plan and apply:
- `terraform plan`
- `terraform apply`

4) Clean up when done:
- `terraform destroy`

## Contributing / structure conventions

If you add a new demo folder:
- Keep it self-contained (its own `providers`, `variables`, `outputs`, and clear README).
- Provide a `terraform.tfvars.example` if the demo benefits from it.
- Do not commit `terraform.tfstate`, `*.tfvars`, or `backend.hcl`.
