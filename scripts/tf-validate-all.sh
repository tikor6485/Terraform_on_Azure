#!/usr/bin/env bash
# =========================================================
# tf-validate-all.sh
# Purpose:
# - Run `terraform init -backend=false` and `terraform validate`
#   in every directory containing at least one .tf file.
#
# Why -backend=false?
# - Validation and provider/plugin checks can run without connecting
#   to a remote backend (no Azure backend access required).
# - This makes local checks and CI faster and more reliable.
# =========================================================

set -euo pipefail

# Find unique directories that contain Terraform files.
# Using git helps avoid scanning ignored/generated folders.
mapfile -t TF_DIRS < <(
  git ls-files '*.tf' \
    | grep -vE '(^|/)\.terraform(/|$)' \
    | xargs -n1 dirname \
    | sort -u
)

if [ "${#TF_DIRS[@]}" -eq 0 ]; then
  echo "No Terraform directories found."
  exit 0
fi

for d in "${TF_DIRS[@]}"; do
  echo "==> Validating: $d"
  terraform -chdir="$d" init -backend=false -input=false
  terraform -chdir="$d" validate
done

echo "OK: terraform validate completed for all Terraform directories."
