#!/usr/bin/env zsh
if (( ${+commands[gh]} )); then
  gh completion -s zsh > "$XDG_DATA_HOME"/zsh/completions/_gh
fi

if (( ${+commands[wezterm]} )); then
  wezterm shell-completion --shell zsh > "$XDG_DATA_HOME"/zsh/completions/_wezterm
fi
