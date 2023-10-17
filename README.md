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

### vscode devcontainer
`settings.json`
```json
  {
    "dotfiles.installCommand": "vscode-devcontainer.sh",
    "dotfiles.repository": "https://github.com/yhorikawa/dotfiles.git",
    "dotfiles.targetPath": "~/dotfiles"
  }
```
