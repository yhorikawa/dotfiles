#!/usr/bin/env bash

set -euo pipefail

# Source common utilities
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
# shellcheck source=../install_utils.sh
source "$(dirname "$SCRIPT_DIR")/install_utils.sh"

# Initialize common variables
initialize_environment_vars

readonly CLAUDE_DIR="${HOME_DIR}/.claude"

create_hard_link() {
	local src="$1"
	local dst="$2"

	if [[ -e "$dst" ]] || [[ -L "$dst" ]]; then
		log_info "Existing file detected at $dst. Skipping... (To update, manually remove the file and re-run)"
		return 0
	fi

	if ln "${DOTFILES_DIR}/${src}" "$dst"; then
		log_info "Created hard link: $src -> $dst"
	else
		log_error "Failed to create hard link: $src -> $dst"
		return 1
	fi
}

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
