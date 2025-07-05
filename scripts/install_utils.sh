#!/usr/bin/env bash
# Dotfiles installation utility functions

# Logging functions
log_info() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

log_error() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2
}

# Directory creation utility
ensure_directory_exists() {
	local dir="$1"
	if [[ ! -d "$dir" ]]; then
		mkdir -p "$dir" || {
			log_error "Failed to create directory: $dir"
			return 1
		}
		log_info "Created directory: $dir"
	fi
}

# Initialize common variables if not already set
initialize_environment_vars() {
	if [[ -z "${DOTFILES_DIR:-}" ]]; then
		local script_dir
		script_dir="$(cd "$(dirname "${BASH_SOURCE[1]}")" && pwd)"
		DOTFILES_DIR="$(dirname "$(dirname "$script_dir")")"
		readonly DOTFILES_DIR
	fi

	if [[ -z "${HOME_DIR:-}" ]]; then
		readonly HOME_DIR="${HOME}"
	fi
}
