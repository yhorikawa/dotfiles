#!/usr/bin/env zsh
if (( ${+commands[gh]} )); then
  gh completion -s zsh > "$XDG_DATA_HOME"/zsh/completions/_gh
fi
