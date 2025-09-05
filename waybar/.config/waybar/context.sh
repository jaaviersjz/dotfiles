#!/bin/zsh

while true; do
  TITLE=$(hyprctl activewindow -j | jq -r '.title')
  if [[ $TITLE != "null" ]]; then
    echo "$TITLE"
  else
    echo ""
  fi
  sleep 0.2
done
