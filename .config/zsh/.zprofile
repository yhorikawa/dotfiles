if [ -d /opt/homebrew ]; then
  eval $(/opt/homebrew/bin/brew shellenv)
  fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fi
