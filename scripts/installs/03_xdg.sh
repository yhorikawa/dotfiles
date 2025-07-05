#!/usr/bin/env bash

set -euo pipefail

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=../install_utils.sh
source "$(dirname "$SCRIPT_DIR")/install_utils.sh"

# Initialize common variables
initialize_environment_vars

# XDG directory pairs (type:path)
XDG_DIRS=(
	"cache:${HOME_DIR}/.cache/zsh"
	"state:${HOME_DIR}/.local/state/zsh"
	"data:${HOME_DIR}/.local/share/zsh"
	"completions:${HOME_DIR}/.local/share/zsh/completions"
)

install() {
	log_info "Creating XDG directories..."

	for pair in "${XDG_DIRS[@]}"; do
		type="${pair%%:*}"
		dir="${pair#*:}"
		ensure_directory_exists "$dir"
		type_upper=$(echo "$type" | tr '[:lower:]' '[:upper:]')
		log_info "Created \$XDG_${type_upper}_HOME directory: $dir"
	done
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	install
fi
