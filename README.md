# Terraform-Tutorial-on-Azure
This repository contains Terraform code for various Azure projects I am working on. Using Terraform allows me to easily provision and manage infrastructure as code, making it simpler and more efficient to deploy and scale applications on Azure. Feel free to browse the code and use it as a reference for your own Azure projects.

# Terraform_On_Azure

This repository is a collection of Terraform labs on Microsoft Azure. Each lab is self-contained and lives in its own folder, so you can run Terraform commands from inside a lab directory without affecting other labs.

## How this repo is organized
- Each folder represents a single lab/demo (for example: AZ_Resource_Groups, AZ_VNet, AZ_Storage, etc.)
- Each lab folder typically includes: main.tf, providers.tf, variables.tf, outputs.tf, README.md, and terraform.tfvars.example
- terraform.tfvars is local-only and intentionally not committed

## Prerequisites
- Terraform (>= 1.0)
- Azure CLI (az)
- An active Azure subscription

## Authentication (local)
- az login
- az account list -o table
- az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"

## Running a lab
1) cd into a lab folder (example: AZ_Resource_Groups)
2) terraform init
3) terraform fmt
4) terraform validate
5) terraform plan
6) terraform apply

## Cleanup
When you are done testing a lab:
- terraform destroy

## Notes
- This repo avoids committing sensitive data. Keep secrets in environment variables or secure secret managers.
- terraform.tfvars is ignored by design. Use terraform.tfvars.example as a reference.
- .terraform.lock.hcl should be committed to keep provider versions consistent across environments.
- Azure resources may incur costs. Always destroy resources when finished.

## Labs
- AZ_Resource_Groups
- (more labs will be added as the repo grows)

