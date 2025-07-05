# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 出力設定

日本語で応答してください。
コードのコメントなどは元の言語のままにしてください。

全角記号より半角記号を優先して使ってください。
特に全角括弧は禁止。

## プロジェクト構造

このリポジトリは個人用dotfilesを管理するプロジェクトです。

### 主要なディレクトリ構成

- `install.sh`: メインインストールスクリプト
- `scripts/installs/`: 各種インストールスクリプト (番号順で実行)
- `.config/`: 各種設定ファイル
- `zsh/`, `bash/`: シェル関連設定
- `Brewfile`: Homebrewでインストールするパッケージ一覧

### インストールスクリプトの構造

インストールスクリプトは以下の順序で実行されます:

1. `01_symlinks.sh`: 設定ファイルのシンボリックリンク作成
2. `02_claude.sh`: Claude設定のハードリンク作成
3. `03_xdg.sh`: XDG準拠のディレクトリ作成

各スクリプトは`install()`関数を実装し、共通ユーティリティを`install_utils.sh`から読み込みます。

## 開発コマンド

### セットアップ

```bash
bash install.sh
```

### シェルスクリプトの品質チェック

```bash
make lint                  # shellcheckによるリント
make format                # shfmtによるフォーマット
make lint-github-actions   # GitHub Actionsワークフローのリント (actionlint, ghalint)
make lint-all              # 全てのリント実行
```

### 依存関係管理

- `mise.toml`: shellcheck、shfmt、actionlint、ghalintの管理
- `Brewfile`: Homebrewパッケージの管理

### ワークフロー

- シェルスクリプトを編集した場合はタスク実行後にlintとformatを実行しエラーを修正してください。
- GitHub Actionsワークフローを編集した場合はタスク実行後にlint-github-actionsを実行しエラーを修正してください。

## CI/CD

### GitHub Actions

- `.github/workflows/ci.yml`: 自動的にlint/formatチェックと動作保証テストを実行
  - Push・Pull Request時に自動実行
  - shellcheckによるシェルスクリプトのリント
  - actionlint・ghalintによるGitHub Actionsワークフローのリント
  - shfmtによるフォーマットチェック
  - インストールスクリプトの構文チェック
