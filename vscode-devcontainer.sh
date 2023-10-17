#!/usr/bin/env bash

DOTFILES_DIR=$(pwd)

INSTALL_MAPPINGS="
zsh/.zshrc                        .zshrc
bash/.bashrc                      .bashrc
.config/starship.toml             .config/starship.toml
.config/sheldon/zsh/plugins.toml  .config/sheldon/zsh/plugins.toml
.config/sheldon/bash/plugins.toml .config/sheldon/bash/plugins.toml
.config/git/ignore                .config/git/ignore
.vim                              .vim
"

install_starship() {
    echo "Installing Starship..."
    sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
}

install_sheldon() {
    echo "Installing Sheldon..."
    curl --proto '=https' -fLsS https://rossmacarthur.github.io/install/crate.sh \
    |  bash -s -- --repo rossmacarthur/sheldon --to /usr/local/bin
}

# Function to create symbolic links based on provided mappings
create_symbolic_links() {
    echo "Creating symbolic links..."
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

install_starship
install_sheldon
create_symbolic_links
echo "Done!"
