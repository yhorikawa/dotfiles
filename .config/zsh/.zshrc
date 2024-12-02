: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"

if (which mise > /dev/null); then
  eval "$(mise activate zsh)"
fi

if which sheldon > /dev/null; then
  export SHELDON_CONFIG_DIR="$XDG_CONFIG_HOME/sheldon/zsh"
  export SHELDON_DATA_DIR="$XDG_DATA_HOME/sheldon/zsh"
  eval "$(sheldon source)"
fi
