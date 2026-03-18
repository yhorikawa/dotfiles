#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR
INSTALLS_DIR="${DOTFILES_DIR}/scripts/installs"
readonly INSTALLS_DIR

# shellcheck source=/dev/null
source "${DOTFILES_DIR}/scripts/install_utils.sh"

main() {
	# Parse arguments
	while [[ $# -gt 0 ]]; do
		case "$1" in
		--force)
			export DOTFILES_FORCE=1
			;;
		*)
			log_error "Unknown option: $1"
			return 1
			;;
		esac
		shift
	done

	log_info "Starting dotfiles installation..."
	log_info "Dotfiles directory: $DOTFILES_DIR"

	# Execute all install scripts in order
	for script in "${INSTALLS_DIR}"/*.sh; do
		if [[ -f "$script" ]]; then
			log_info "Running $(basename "$script")..."
			bash "$script"
			log_info "Successfully completed $(basename "$script")"
		fi
	done

	log_info "Installation completed successfully!"
}

main "$@"
