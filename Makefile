# Makefile for dotfiles

# Variables
SHELL_FILES := $(shell find . -name "*.sh" -type f)

# Format shell scripts with shfmt
.PHONY: format
format:
	@echo "Formatting shell scripts with shfmt..."
	shfmt -w $(SHELL_FILES)

# Lint shell scripts with shellcheck
.PHONY: lint
lint:
	@echo "Linting shell scripts with shellcheck..."
	shellcheck $(SHELL_FILES)

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  format    - Format shell scripts with shfmt"
	@echo "  lint      - Lint shell scripts with shellcheck"
	@echo "  help      - Show this help message"
