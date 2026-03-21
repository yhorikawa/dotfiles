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

install() {
	log_info "Creating symbolic links for .local/ files..."

	# Auto-discover and symlink all files under .local/
	while IFS= read -r file; do
		create_symbolic_link "$file" "${HOME_DIR}/${file}"
	done < <(cd "$DOTFILES_DIR" && find .local -type f | sort)
}

install
