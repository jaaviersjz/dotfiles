#!/usr/bin/zsh

kitty=$(command -v kitty)
nvim=$(command -v nvim)
clipboard=$(command -v wl-copy)
compose_file="/tmp/nvimE.py"
pid_file="/tmp/vimeverywhere-pid"

# Clean up old files
rm -f $compose_file $pid_file

# Build Kitty command string
kitty_cmd="kitty @ set-window-title 'vimeverywhere' \
  && kitty @ ls | jq -r '.[].tabs[].windows[] | select(.title == \"vimeverywhere\") | .pid' > $pid_file \
  && VIM_TRANSPARENT=1 nvim -n --cmd 'nnoremap <buffer> q :wq<CR>' +startinsert $compose_file"

# Launch the editor
$kitty -T vimeverywhere --override background_opacity=0.5 zsh -c "${kitty_cmd}"

# Wait for pid to be written
sleep 0.5
vimeverywhere_pid=$(cat $pid_file)

# Wait for the process to finish (i.e., Neovim session exits)
while kill -0 $vimeverywhere_pid 2>/dev/null; do sleep 0.15; done

if [[ -s $compose_file ]]; then
  $clipboard < $compose_file
  wtype -M ctrl -M shift v -m ctrl -m shift
fi

# Final cleanup
rm -f $compose_file $pid_file
