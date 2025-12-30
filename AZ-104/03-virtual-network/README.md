# AZ Virtual Network (VNet) Demo

## Overview
This demo creates a Resource Group and a Virtual Network (VNet) in Azure using Terraform.

## What this demo creates
	•	Resource Group
	•	Virtual Network (VNet) with an address space (CIDR)

## Prerequisites
	•	Azure CLI installed and logged in (az login)
	•	Terraform installed
	•	You must have an Azure subscription selected (az account show / az account set)

## Configuration
	•	Recommended: set subscription id as an environment variable (TF_VAR_subscription_id) so nothing sensitive is stored in files.
	•	You can copy terraform.tfvars.example to terraform.tfvars and adjust values, but do not commit terraform.tfvars to Git.

## Run
	1.	Go to this demo folder
	2.	terraform init
	3.	terraform validate
	4.	terraform plan
	5.	terraform apply

## Cleanup
	•	terraform destroy

## Notes
	•	Resource names use: resource_prefix + environment to stay consistent across demos.
	•	VNet address space must be a valid CIDR block list (example: 10.10.0.0/16).
