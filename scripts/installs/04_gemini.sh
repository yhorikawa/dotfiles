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

readonly GEMINI_DIR="${HOME_DIR}/.gemini"

install() {
	log_info "Creating hard links for Claude configuration files..."

	ensure_directory_exists "$GEMINI_DIR"

	create_hard_link ".config/gemini/GEMINI.md" "${GEMINI_DIR}/GEMINI.md"
	create_hard_link ".config/claude/CLAUDE.md" "${GEMINI_DIR}/CLAUDE.md"
	create_hard_link ".config/gemini/settings.json" "${GEMINI_DIR}/settings.json"
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	install
fi
