# ------------------------------
# Zinit Setting
# ------------------------------
source $ZDOTDIR/zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light sindresorhus/pure
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# ------------------------------
# History Setting
# ------------------------------
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups

# ------------------------------
# alias Setting
# ------------------------------
alias ll='ls -alF'
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
alias ..='cd ..'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ------------------------------
# # load .zshrc_*
# ------------------------------
[ -f $ZDOTDIR/.zshrc_`uname`  ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_local    ] && . $ZDOTDIR/.zshrc_local

# ---------------------------------------------------------
# completion
# ---------------------------------------------------------

# コマンド補完
autoload -Uz compinit && compinit
