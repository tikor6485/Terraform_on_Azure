# Terraform on Azure (Labs)

This repository contains a collection of hands-on Terraform labs focused on provisioning and managing Microsoft Azure infrastructure. Each lab is designed to be self-contained, repeatable, and easy to reuse as a reference for real-world Infrastructure as Code workflows.

## Goals
- Build practical Terraform skills using Azure as the target platform
- Provide small, focused examples that can be executed independently
- Keep the repository clean and safe to share (no secrets committed)

## Repository Structure
- Each folder under this repository represents an independent lab (a standalone Terraform working directory).
- Every lab follows a consistent structure so you can quickly navigate, run, and extend it.

Typical lab folder contents:
- main.tf: core resources for the lab
- provider(s).tf: provider configuration and Terraform settings
- variables.tf: input variables used by the lab
- outputs.tf: outputs produced by the lab
- terraform.tfvars.example: example variable values (safe to commit)
- terraform.tfvars: local-only values (not committed)
- README.md: lab-specific instructions and notes

## Prerequisites
- Terraform (>= 1.0)
- Azure CLI (az)
- An active Azure subscription

## Authentication
For local development, Azure CLI authentication is the simplest approach:
- Run az login
- Confirm the right subscription is selected (az account list) and set it (az account set)

For CI/CD or non-interactive environments, use a Service Principal and keep credentials out of Git (environment variables or a secure secret manager).

## How to Use This Repository
1) Choose a lab folder (for example: AZ_Resource_groups).
2) Read the lab’s README.md for inputs and expectations.
3) (Optional) Create local variables by copying terraform.tfvars.example to terraform.tfvars and filling in your values.
4) Run Terraform inside that lab folder (init, plan, apply).
5) When finished, destroy resources to avoid unnecessary costs.

## Labs
- AZ_Resource_groups: Creates an Azure Resource Group (foundation for most Azure deployments)

More labs will be added over time, following the same structure and conventions.

## Topics Covered Across Labs
These labs are intended to cover both Terraform fundamentals and Azure-specific patterns, including:
- Terraform workflow: init, fmt, validate, plan, apply, destroy
- Input variables, outputs, locals, expressions, and functions
- Provider configuration and version pinning
- Resource lifecycle and dependency management
- State fundamentals (local state first), then remote state patterns
- Common Azure building blocks (resource groups, networking, storage, compute)
- Identity and access patterns (RBAC) where applicable
- Reusability patterns (naming conventions, tagging, and modular structure as the repo grows)

## Safety and Cost Notes
- Do not commit secrets: terraform.tfvars, .env files, keys, and credential exports are intentionally ignored via .gitignore.
- Azure resources may incur costs. Always destroy resources when you complete a lab.
- Prefer running labs in a dedicated subscription or resource group when possible.

## Contributing
If you notice an issue or want to improve a lab:
- Open an issue with details
- Or submit a pull request with a clear description of the change
