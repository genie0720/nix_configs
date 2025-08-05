{ config, pkgs, lib, ... }:

{
  home.file.".config/wlogout/layout".text = ''
    {
        "label" : "lock",
        "action" : "hyprlock",
        "text" : "lock",
        "keybind" : "l"
    }
    {
        "label" : "hibernate",
        "action" : "systemctl hibernate || loginctl hibernate",
        "text" : "downloading",
        "keybind" : "h"
    }
    {
        "label" : "logout",
        "action" : "hyprctl clients -j | jq -r '.[].pid' | xargs kill; pkill Hyprland || pkill sway || pkill niri || loginctl terminate-user $USER",
        "text" : "logout",
        "keybind" : "e"
    }
    {
        "label" : "shutdown",
        "action" : "hyprctl clients -j | jq -r '.[].pid' | xargs kill; systemctl poweroff || loginctl poweroff",
        "text" : "power_settings_new",
        "keybind" : "s"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend || loginctl suspend",
        "text" : "bedtime",
        "keybind" : "u"
    }
    {
        "label" : "reboot",
        "action" : "hyprctl clients -j | jq -r '.[].pid' | xargs kill; systemctl reboot || loginctl reboot",
        "text" : "restart_alt",
        "keybind" : "r"
    }
  '';
}
