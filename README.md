# .dotfiles

## install.shを実行する
```
sh install.sh
```

## cloneする場合
```
git clone --recursive git@github.com:yhorikawa/.dotfiles.git
```
## submoduleのupdate
```
git submodule update --init --recursive
```
## zshenvに以下を記載
```
export ZDOTDIR=$HOME/.dotfiles/.zsh
```
## zshrc_localを作成
```
cp .zshrc_local.tmp .zshrc_local
```
