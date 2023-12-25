# dotfiles

## setup
```sh
bash install.sh
```

## Manual Install Dependencies
### Mac OS
use [Homebrew](https://brew.sh/)
```bash
brew install sheldon starship
brew install --cask wezterm
brew tap homebrew/cask-fonts
brew install font-udev-gothic-nf
```

## vscode devcontainer
`settings.json`
```json
  {
    "dev.containers.defaultFeatures": {
      "ghcr.io/devcontainers-contrib/features/gh-release:1": {
        "binaryNames": "sheldon",
        "repo": "rossmacarthur/sheldon",
        "version": "latest"
      },
      "ghcr.io/devcontainers-contrib/features/starship:1": {}
    },
    "dotfiles.installCommand": "install.sh",
    "dotfiles.repository": "https://github.com/yhorikawa/dotfiles.git",
    "dotfiles.targetPath": "~/dotfiles"
  }
```
