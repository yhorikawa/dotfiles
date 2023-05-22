# ------------------------------
# Zinit Setting
# ------------------------------
source $ZDOTDIR/zinit/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

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
# # lazy loading
# ------------------------------
zinit wait lucid null for \
    atinit'source "$ZDOTDIR/.zshrc_lazy"' \
    @'zdharma-continuum/null'
