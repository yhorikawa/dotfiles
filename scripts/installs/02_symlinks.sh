#!/usr/bin/env bash

set -euo pipefail

# Source common utilities
if [[ -z "${SCRIPT_DIR:-}" ]]; then
	SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
	readonly SCRIPT_DIR
fi
# shellcheck source=/dev/null
source "$(dirname "$SCRIPT_DIR")/install_utils.sh"

# Initialize common variables
initialize_environment_vars

# Non-.config symlink pairs (source path differs from destination)
SYMLINK_PAIRS=(
	"bash/.bashrc:.bashrc"
	".zshenv:.zshenv"
	".vim:.vim"
)

install() {
	log_info "Creating symbolic links..."

	for pair in "${SYMLINK_PAIRS[@]}"; do
		src="${pair%%:*}"
		dst="${pair#*:}"
		create_symbolic_link "$src" "${HOME_DIR}/${dst}"
	done
}

install
