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

# ---------------------------------------------------------
# completion
# ---------------------------------------------------------

# コマンド補完
autoload -Uz compinit && compinit

# ------------------------------
# Other Setting
# ------------------------------
setopt auto_cd

# ------------------------------
# # load .zshrc_*
# ------------------------------
[ -f $ZDOTDIR/.zshrc_`uname`  ] && . $ZDOTDIR/.zshrc_`uname`
[ -f $ZDOTDIR/.zshrc_alias    ] && . $ZDOTDIR/.zshrc_alias
[ -f $ZDOTDIR/.zshrc_local    ] && . $ZDOTDIR/.zshrc_local
