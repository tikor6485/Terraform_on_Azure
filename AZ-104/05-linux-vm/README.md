# AZ Linux VM Demo

## Overview

This demo provisions a basic Azure Linux Virtual Machine using Terraform. It creates a minimal network stack (VNet/Subnet/Public IP/NIC/NSG) and boots the VM with cloud-init using filebase64().

## What this demo creates

• Resource Group  
• Virtual Network (VNet)  
• Subnet  
• Public IP (Static, Standard)  
• Network Security Group (NSG) + SSH rule (restricted)  
• Network Interface (NIC) + NSG association  
• Linux Virtual Machine (Ubuntu 22.04 LTS)  
• Random suffix for unique naming  

## Prerequisites

• Terraform (>= 1.0)  
• Azure CLI installed and logged in (az login)  
• An active Azure subscription selected (az account show / az account set)  
• An SSH keypair on your machine (use the public key in inputs)  

## Authentication

Option A: Azure CLI (local)
```
az login
az account show
az account set --subscription "<SUBSCRIPTION_ID>"
```

Option B: Service Principal (CI/CD)  
Use environment variables or a secure secret store (do not hardcode secrets in files).

## Configuration

• Recommended: set subscription id via environment variable:
```
export TF_VAR_subscription_id="<SUBSCRIPTION_ID>"
```

• Recommended: create a local tfvars file (not committed):
```
cp terraform.tfvars.example terraform.tfvars
```
Fill in admin_public_ssh_key and allowed_ssh_cidr (your public IP /32).

• cloud-init:  
This demo reads cloud-init content from cloud-init.yaml.example using filebase64() and passes it to the VM as custom_data.

## Run

From inside this folder:
1. terraform init
2. terraform fmt
3. terraform validate
4. terraform plan
5. terraform apply

## SSH

• After apply, use the output ssh_command.  
• SSH is allowed only from allowed_ssh_cidr.  

## Cleanup

• terraform destroy

## Notes

• Do not set allowed_ssh_cidr to 0.0.0.0/0.  
• Do not commit terraform.tfvars or any private SSH keys.  
• VM resources may incur cost; destroy when finished.
