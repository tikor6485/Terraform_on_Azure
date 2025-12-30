# AZ_Storage_Account

This demo provisions an Azure Storage Account and a private Blob container using Terraform. A dedicated Resource Group is created for the demo so it can be deployed and removed safely.

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
This demo expects subscription_id as an input variable. If you exported TF_VAR_subscription_id in your shell profile, no tfvars file is required.

Optional local tfvars (not committed):
- Copy terraform.tfvars.example to terraform.tfvars
- Fill in subscription_id and optionally adjust location, prefix, or container name

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
- storage_account_name
- storage_account_id
- primary_blob_endpoint
- container_name
