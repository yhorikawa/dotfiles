if [ -d /opt/homebrew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# Added by OrbStack: command-line tools and integration
if [[ -f ~/.orbstack/shell/init.zsh ]]; then
    source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi

if (which mise > /dev/null); then
  eval "$(mise activate zsh --shims)"
fi
