#!/bin/zsh

PIDFILE="/tmp/wlsunset.pid"

if [[ -f "$PIDFILE" ]]; then
	kill "$(cat "$PIDFILE")" 2> /dev/null	
	rm "$PIDFILE"
	notify-send "☀️ Night Mode Disabled" -t 1000
else 
	wlsunset -t 4750 -T 4751 -g 0.9 &
	echo $! > "$PIDFILE"
	notify-send "🌙 Night Mode Enabled" -t 1000
fi
