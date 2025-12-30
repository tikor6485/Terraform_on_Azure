# AZ_Network_Stack

## Overview
This demo provisions a simple Azure networking stack using Terraform. It is intended as a practical, real-world baseline for networking components that are commonly created together.

## What this demo creates
- Resource Group
- Virtual Network (VNet)
- Subnet
- Public IP Address (Standard, Static)
- Network Interface (NIC) attached to the subnet and linked to the public IP

## Prerequisites
- Terraform (>= 1.0)
- Azure CLI installed (`az`)
- Logged in to Azure (`az login`)
- An active Azure subscription selected (`az account show` / `az account set`)

## Authentication
- Recommended: set the subscription id via environment variable so nothing sensitive is stored in files:
  - TF_VAR_subscription_id
- Alternative (local only): copy terraform.tfvars.example to terraform.tfvars and edit values, but never commit terraform.tfvars.

## Configuration
- Resource names are built from: resource_prefix + environment (for consistency across demos)
- VNet and Subnet CIDRs must be valid address ranges (for example: 10.20.0.0/16 and 10.20.1.0/24)

## Run
1. Go to this demo folder
2. terraform init
3. terraform fmt
4. terraform validate
5. terraform plan
6. terraform apply

## Cleanup
- terraform destroy
