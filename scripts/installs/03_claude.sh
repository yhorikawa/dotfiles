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

readonly CLAUDE_DIR="${HOME_DIR}/.claude"

install() {
	log_info "Creating hard links for Claude configuration files..."

	ensure_directory_exists "$CLAUDE_DIR"

	create_hard_link ".config/claude/CLAUDE.md" "${CLAUDE_DIR}/CLAUDE.md"
	create_hard_link ".config/claude/settings.json" "${CLAUDE_DIR}/settings.json"
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	install
fi
