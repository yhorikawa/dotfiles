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

# Source and destination pairs for symbolic links
SYMLINK_PAIRS=(
	".config/claude/CLAUDE.md:.config/claude/CLAUDE.md"
	".config/claude/settings.json:.config/claude/settings.json"
	".config/ccstatusline/settings.json:.config/ccstatusline/settings.json"
)

install() {
	log_info "Creating symbolic links for Claude configuration files..."

	for pair in "${SYMLINK_PAIRS[@]}"; do
		src="${pair%%:*}"
		dst="${pair#*:}"
		create_symbolic_link "$src" "${HOME_DIR}/${dst}"
	done
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	install
fi
