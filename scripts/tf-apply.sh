#!/usr/bin/env bash
# =========================================================
# tf-apply.sh
# Purpose:
# - Run `terraform init` + `terraform apply` for ONE directory.
#
# Notes:
# - This will create real Azure resources if the directory contains them.
# - Ensure you understand costs and clean up after testing.
# =========================================================

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <working_directory>"
  echo "Example: $0 az-104/05-linux-vm"
  exit 1
fi

WD="$1"

if [ ! -d "$WD" ]; then
  echo "Error: directory not found: $WD"
  exit 1
fi

echo "==> Terraform init: $WD"
if [ -f "$WD/backend.hcl" ]; then
  terraform -chdir="$WD" init -backend-config="backend.hcl" -input=false
else
  terraform -chdir="$WD" init -backend=false -input=false
fi

echo "==> Terraform apply: $WD"
terraform -chdir="$WD" apply
