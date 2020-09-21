# zshのテーマ
fpath+=$HOME/.dotfiles/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

# ------------------------------
# alias Setting
# ------------------------------
alias ll='ls -lF'
alias ll='ls -lh'
alias ll='ls -l'
alias la='ls -A'

alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'

alias d='docker'
alias dc='docker-compose'

alias c='clear'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ------------------------------
# # load .zshrc_*
# ------------------------------
[ -f $ZDOTDIR/.zshrc_`uname`  ] && . $ZDOTDIR/.zshrc_`uname`