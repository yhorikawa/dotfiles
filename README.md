# .dotfiles

## cloneする場合
```
git clone --recursive git@github.com:yhorikawa/.dotfiles.git
```
## submoduleのupdate
```
git submodule update --init --recursive
```
## シンボリックリンク
zshrc
```
ln -s $HOME/.dotfiles/.zsh/.zshrc .zshrc
```
## zshenvに以下を記載
```
export ZDOTDIR=$HOME/.dotfiles/.zsh
```
