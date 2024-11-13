export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_BIN_HOME="$HOME"/.local/bin
path=($XDG_BIN_HOME $path)
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

if (which mise > /dev/null); then
  case $- in
    *i*) eval "$(mise activate)" ;;
    *) eval "$(mise activate --shims)" ;;
  esac
fi
