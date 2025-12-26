# AZ_Resource_Groups

This demo provisions a single Azure Resource Group using Terraform.

## Prerequisites
- Terraform (>= 1.0)
- Azure CLI (az)
- An active Azure subscription

## Authentication

Option A: Azure CLI (local)
- az login
- az account list -o table
- az account set --subscription "<SUBSCRIPTION_ID_OR_NAME>"

Option B: Service Principal (CI/CD)
Use environment variables or a secure secret manager. Avoid committing secrets.

## Configuration
Create a local tfvars file (optional):
- cp terraform.tfvars.example terraform.tfvars

## Run
From inside this folder:
- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply

## Destroy
- terraform destroy

## Outputs
- resource_group_name
- resource_group_id


