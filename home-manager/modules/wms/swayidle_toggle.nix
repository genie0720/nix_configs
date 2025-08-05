 { config, ... }:

{
  home.file = {
    "${config.home.homeDirectory}/.config/waybar/swayidle-toggle.sh" = {
      text = ''
#!/usr/bin/env bash

STATUS_FILE="/tmp/swayidle_status"

if [ ! -f "$STATUS_FILE" ]; then
  echo "1" > "$STATUS_FILE"
fi

STATUS=$(cat "$STATUS_FILE")

if [ "$1" == "--toggle" ]; then
  if [ "$STATUS" == "1" ]; then
    pkill swayidle
    echo "0" > "$STATUS_FILE"
  else
    swayidle -w \
      timeout 300 'swaylock -f -c 000000' \
      timeout 600 'swaymsg "output * dpms off"' \
      resume 'swaymsg "output * dpms on"' \
      before-sleep 'swaylock -f -c 000000' &
    disown
    echo "1" > "$STATUS_FILE"
  fi
else
  if [ "$STATUS" == "1" ]; then
    echo '{"text":"⚫","tooltip":"Swayidle is active"}'
  else
    echo '{"text":"⚪","tooltip":"Swayidle is inactive"}'
  fi
fi
'';
executable = true;
    };
  };
}