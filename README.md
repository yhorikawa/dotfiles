# dotfiles

個人用dotfiles管理プロジェクト

## 概要

このリポジトリは個人の開発環境の設定ファイル(dotfiles)を管理するためのプロジェクトです。シェル設定、エディタ設定、ターミナル設定など、開発に必要な各種設定を一元管理し、新しい環境で素早くセットアップできるようにしています。

## 主要機能

- 設定ファイルの自動シンボリックリンク作成
- Homebrewを使用したパッケージ管理
- VS Code拡張機能の自動インストール
- シェルスクリプトの品質チェック機能
- XDG準拠のディレクトリ構成

## セットアップ

### 基本インストール

```bash
bash install.sh
```

### インストール内容

インストールスクリプトは以下の順序で実行されます:

1. `01_symlinks.sh` - 設定ファイルのシンボリックリンク作成
2. `02_claude.sh` - Claude設定のハードリンク作成
3. `03_xdg.sh` - XDG準拠のディレクトリ作成

### 手動インストール依存関係

macOSでは[Homebrew](https://brew.sh/)を使用して以下をインストールしてください:

```bash
# 基本ツール
brew install sheldon starship mise

# フォント
brew tap homebrew/cask-fonts
brew install font-udev-gothic-nf font-jetbrains-mono

# ターミナル
brew install --cask wezterm

# すべての依存関係をインストール
brew bundle
```

## プロジェクト構造

```txt
dotfiles/
├── install.sh              # メインインストールスクリプト
├── Brewfile                # Homebrewパッケージ一覧
├── Makefile                # 開発用タスク
├── mise.toml               # mise設定
├── scripts/
│   ├── installs/           # インストールスクリプト群
│   │   ├── 01_symlinks.sh  # シンボリックリンク作成
│   │   ├── 02_claude.sh    # Claude設定
│   │   └── 03_xdg.sh       # XDGディレクトリ作成
│   └── install_utils.sh    # 共通ユーティリティ
├── .config/                # 各種設定ファイル
├── zsh/                    # Zsh設定
├── bash/                   # Bash設定
└── aliases/                # エイリアス設定
```

## 開発

### 品質チェック

```bash
# シェルスクリプトのリント
make lint

# シェルスクリプトのフォーマット
make format
```

### 使用ツール

- **shellcheck**: シェルスクリプトの静的解析
- **shfmt**: シェルスクリプトのフォーマット
- **mise**: 開発ツールのバージョン管理
- **sheldon**: Zshプラグイン管理
- **starship**: プロンプトカスタマイズ

## VS Code Dev Container

VS Codeの設定ファイル(`settings.json`)に以下を追加することで、Dev Containerでも同じ環境を再現できます:

```json
{
  "dev.containers.defaultFeatures": {
    "ghcr.io/devcontainers-extra/features/gh-release:1": {
      "binaryNames": "sheldon",
      "repo": "rossmacarthur/sheldon",
      "version": "latest"
    },
    "ghcr.io/devcontainers-extra/features/starship:1": {},
    "ghcr.io/devcontainers/features/common-utils:2": {
      "configureZshAsDefaultShell": true,
      "installZsh": true,
      "upgradePackages": true
    }
  }
}
```

## 含まれる設定

- **シェル**: Zsh/Bash設定とプラグイン
- **エディタ**: VS Code設定と拡張機能
- **ターミナル**: WeZterm設定
- **Git**: グローバル設定
- **開発ツール**: mise、sheldon、starshipの設定
