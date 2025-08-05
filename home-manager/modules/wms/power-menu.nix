{ config, lib, ... }:

{
  home.file.".config/waybar/scripts/power-menu.sh".text = ''
    #!/usr/bin/env bash
    entries="Lock Logout Suspend Reboot Shutdown"
    selected=$(echo "$entries" | wofi --dmenu | awk '{print tolower($1)}')

    case $selected in
      lock) ${config.home.homeDirectory}/.config/swaylock/lock.sh ;;
      logout) swaymsg exit ;;
      suspend) systemctl suspend ;;
      reboot) systemctl reboot ;;
      shutdown) systemctl poweroff ;;
    esac
  '';

  home.activation.setPowerMenuExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    chmod +x ${config.home.homeDirectory}/.config/waybar/scripts/power-menu.sh
  '';
}
