{ config, lib, pkgs, ... }:

{
  home.file.".config/hypr/hypridle.conf".text = ''
    # $lock_cmd = hyprlock
    $lock_cmd = hyprlock
    $suspend_cmd = systemctl suspend || loginctl suspend

    general {
        lock_cmd = $lock_cmd
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch global quickshell:lockFocus
        inhibit_sleep = 3
    }

    listener {
        timeout = 300 # 5mins
        on-timeout = hyprlock
    }

    listener {
        timeout = 600 # 10mins
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }

    listener {
        timeout = 900 # 15mins
        on-timeout = $suspend_cmd
    }
  '';
}
