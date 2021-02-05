# ------------------------------
# Zplug Setting
# ------------------------------
source $ZDOTDIR/zplug/init.zsh

zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

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
