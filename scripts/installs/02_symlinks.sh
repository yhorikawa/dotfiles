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
	"bash/.bashrc:.bashrc"
	".zshenv:.zshenv"
	".config/zsh/.zprofile:.config/zsh/.zprofile"
	".config/zsh/.zshrc:.config/zsh/.zshrc"
	".config/starship.toml:.config/starship.toml"
	".config/sheldon/zsh/plugins.toml:.config/sheldon/zsh/plugins.toml"
	".config/sheldon/bash/plugins.toml:.config/sheldon/bash/plugins.toml"
	".config/git/ignore:.config/git/ignore"
	".config/wezterm/wezterm.lua:.config/wezterm/wezterm.lua"
	".config/git/config:.config/git/config"
	".vim:.vim"
)

install() {
	log_info "Creating symbolic links..."

	for pair in "${SYMLINK_PAIRS[@]}"; do
		src="${pair%%:*}"
		dst="${pair#*:}"
		create_symbolic_link "$src" "$dst"
	done
}

# Run if script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	install
fi
