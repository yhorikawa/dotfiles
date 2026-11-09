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

export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# herdr は OSC 8 を描画できるが、Claude Code の対応端末判定に TERM_PROGRAM=herdr が含まれない
if [[ $TERM_PROGRAM == herdr ]]; then
  export FORCE_HYPERLINK=1
fi
