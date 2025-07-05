# Makefile for dotfiles

# Variables
SHELL_FILES := $(shell find . -name "*.sh" -type f)
GITHUB_WORKFLOW_FILES := $(shell find .github/workflows -name "*.yml" -o -name "*.yaml" 2>/dev/null || echo "")

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

# Lint GitHub Actions workflows
.PHONY: lint-github-actions
lint-github-actions:
	@echo "Linting GitHub Actions workflows..."
	@if [ -n "$(GITHUB_WORKFLOW_FILES)" ]; then \
		echo "Running actionlint..."; \
		actionlint $(GITHUB_WORKFLOW_FILES); \
		echo "Running ghalint..."; \
		ghalint run; \
	else \
		echo "No GitHub Actions workflow files found"; \
	fi

# Run all linting
.PHONY: lint-all
lint-all: lint lint-github-actions

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  format              - Format shell scripts with shfmt"
	@echo "  lint                - Lint shell scripts with shellcheck"
	@echo "  lint-github-actions - Lint GitHub Actions workflows with actionlint and ghalint"
	@echo "  lint-all            - Run all linting (shell scripts and GitHub Actions)"
	@echo "  help                - Show this help message"
