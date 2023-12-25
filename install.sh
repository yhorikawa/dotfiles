#!/bin/bash

DOTFILES_DIR=$(pwd)

INSTALL_MAPPINGS="
bash/.bashrc                      .bashrc
.zshenv                           .zshenv
.config/zsh/.zprofile             .config/zsh/.zprofile
.config/zsh/.zshrc                .config/zsh/.zshrc
.config/starship.toml             .config/starship.toml
.config/sheldon/zsh/plugins.toml  .config/sheldon/zsh/plugins.toml
.config/sheldon/bash/plugins.toml .config/sheldon/bash/plugins.toml
.config/git/ignore                .config/git/ignore
.config/wezterm/wezterm.lua       .config/wezterm/wezterm.lua
.config/git/config                .config/git/config
.vim                              .vim
"

# Function to create symbolic links based on provided mappings
create_symbolic_links() {
    echo "$INSTALL_MAPPINGS" | while read MAP
    do
        [ ! -n "$MAP" ] && continue

        ARGS=($MAP)
        src="${ARGS[0]}"
        dst="${ARGS[1]}"

        mkdir -p "$(dirname "$HOME/$dst")"

        if [ -e "$HOME/$dst" ] || [ -h "$HOME/$dst" ]; then
            echo "Existing file or link detected at $HOME/$dst. Skipping..."
            continue
        fi

        ln -s "$DOTFILES_DIR/$src" "$HOME/$dst"
        echo "Created symbolic link: $src -> $dst"
    done
}

echo "Creating symbolic links..."
create_symbolic_links
echo "Creating \$XDG_CACHE_HOME/zsh directory..."
mkdir -p "$HOME/.cache/zsh"
echo "Done!"
