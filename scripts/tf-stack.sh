#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/tf-stack.sh AZ-104/08-app-service validate
#   ./scripts/tf-stack.sh AZ-104/07-load-balancing-basic plan
#   TF_AUTO_APPROVE=1 ./scripts/tf-stack.sh AZ-104/06-dns-name-resolution apply

STACK="${1:-}"
ACTION="${2:-plan}"

if [[ -z "${STACK}" ]]; then
  echo "ERROR: stack path is required (e.g., AZ-104/06-dns-name-resolution)" >&2
  exit 1
fi

# Remote state backend defaults (override via env if needed)
TFSTATE_RG="${TFSTATE_RG:-tfstate-demo-dev-rg}"
TFSTATE_SA="${TFSTATE_SA:-tfstatedemodevsa}"
TFSTATE_CONTAINER="${TFSTATE_CONTAINER:-tfstate}"
TFSTATE_USE_AAD="${TFSTATE_USE_AAD:-true}"

# Normalize key to match your pattern: "az-104/xx-.../terraform.tfstate"
KEY_PREFIX="$(echo "${STACK}" | tr '[:upper:]' '[:lower:]')"
STATE_KEY="${KEY_PREFIX}/terraform.tfstate"

# Non-interactive by default (prevents terraform asking questions mid-run)
export TF_INPUT=0
export TF_IN_AUTOMATION=1

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "${repo_root}" ]]; then
  echo "ERROR: run inside the git repo" >&2
  exit 1
fi

stack_dir="${repo_root}/${STACK}"
if [[ ! -d "${stack_dir}" ]]; then
  echo "ERROR: stack directory not found: ${STACK}" >&2
  exit 1
fi

# Helper: init a stack with backend config (temporary file)
tf_init() {
  local dir="$1"
  local key="$2"
  local tmp
  tmp="$(mktemp)"
  cat > "${tmp}" <<EOF
resource_group_name  = "${TFSTATE_RG}"
storage_account_name = "${TFSTATE_SA}"
container_name       = "${TFSTATE_CONTAINER}"
use_azuread_auth     = ${TFSTATE_USE_AAD}
key                  = "${key}"
EOF
  terraform -chdir="${dir}" init -backend-config="${tmp}" -reconfigure >/dev/null
  rm -f "${tmp}"
}

# Helper: read an output from another stack (ensures that stack is inited)
tf_output() {
  local dep_stack="$1"
  local output_name="$2"
  local dep_dir="${repo_root}/${dep_stack}"
  local dep_key
  dep_key="$(echo "${dep_stack}" | tr '[:upper:]' '[:lower:]')/terraform.tfstate"
  tf_init "${dep_dir}" "${dep_key}"
  terraform -chdir="${dep_dir}" output -raw "${output_name}"
}

# Auto-wire dependencies for your known stacks
case "${STACK}" in
  AZ-104/06-dns-name-resolution)
    export TF_VAR_resource_group_name="$(tf_output AZ-104/01-resource-group resource_group_name)"
    export TF_VAR_vnet_name="$(tf_output AZ-104/03-virtual-network vnet_name)"
    ;;
  AZ-104/07-load-balancing-basic)
    export TF_VAR_resource_group_name="$(tf_output AZ-104/01-resource-group resource_group_name)"
    ;;
  AZ-104/08-app-service)
    export TF_VAR_resource_group_name="$(tf_output AZ-104/01-resource-group resource_group_name)"
    ;;
esac

# Ensure this stack is inited with the correct backend every time
tf_init "${stack_dir}" "${STATE_KEY}"

# Format + validate always (fast, deterministic guardrail)
terraform -chdir="${stack_dir}" fmt >/dev/null
terraform -chdir="${stack_dir}" validate >/dev/null

auto_approve=()
if [[ "${TF_AUTO_APPROVE:-0}" == "1" ]]; then
  auto_approve=(-auto-approve)
fi

case "${ACTION}" in
  validate)
    echo "OK"
    ;;
  plan)
    terraform -chdir="${stack_dir}" plan
    ;;
  apply)
    terraform -chdir="${stack_dir}" apply "${auto_approve[@]}"
    ;;
  destroy)
    terraform -chdir="${stack_dir}" destroy "${auto_approve[@]}"
    ;;
  *)
    echo "ERROR: unknown action: ${ACTION} (use validate|plan|apply|destroy)" >&2
    exit 1
    ;;
esac
