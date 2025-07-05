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

create_symbolic_link() {
	local src="$1"
	local dst="$2"
	local full_dst="${HOME_DIR}/${dst}"

	ensure_directory_exists "$(dirname "$full_dst")"

	if [[ -e "$full_dst" ]] || [[ -L "$full_dst" ]]; then
		log_info "Existing file detected at $full_dst. Skipping... (To update, manually remove the file and re-run)"
		return 0
	fi

	if ln -s "${DOTFILES_DIR}/${src}" "$full_dst"; then
		log_info "Created symbolic link: $src -> $dst"
	else
		log_error "Failed to create symbolic link: $src -> $dst"
		return 1
	fi
}
