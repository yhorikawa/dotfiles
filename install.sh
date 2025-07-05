#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR
INSTALLS_DIR="${DOTFILES_DIR}/scripts/installs"
readonly INSTALLS_DIR

# Utility functions
log() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

error() {
	echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $*" >&2
}

main() {
	log "Starting dotfiles installation..."
	log "Dotfiles directory: $DOTFILES_DIR"

	# Execute all install scripts in order
	for script in "${INSTALLS_DIR}"/*.sh; do
		if [[ -f "$script" ]]; then
			log "Running $(basename "$script")..."

			# Source the script to load its functions
			# shellcheck source=/dev/null
			source "$script"

			# Call the unified install function
			if declare -f "install" >/dev/null; then
				install
				log "Successfully completed $(basename "$script")"
			else
				error "No install function found in $(basename "$script")"
				return 1
			fi
		fi
	done

	log "Installation completed successfully!"
}

main "$@"
