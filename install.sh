#!/bin/bash

DOTFILES_DIR=$(pwd)

INSTALL_MAPPINGS="
zsh/.zshrc                       .zshrc
bash/.bashrc                     .bashrc
.config/starship.toml             .config/starship.toml
.config/sheldon/zsh/plugins.toml  .config/sheldon/zsh/plugins.toml
.config/sheldon/bash/plugins.toml .config/sheldon/bash/plugins.toml
.config/git/ignore                .config/git/ignore
.config/wezterm/wezterm.lua       .config/wezterm/wezterm.lua
.vim                              .vim
git/.gitconfig                    .gitconfig
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
echo "Done!"
