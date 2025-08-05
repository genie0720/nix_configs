{ config, pkgs, lib, ... }:

{
  home.file.".config/hypr/hyprland/scripts/zoom.sh".text = ''
    #!/usr/bin/env bash

    # Controls Hyprland's cursor zoom_factor, clamped between 1.0 and 3.0

    get_zoom() {
        hyprctl getoption -j cursor:zoom_factor | jq '.float'
    }

    clamp() {
        local val="$1"
        awk "BEGIN {
            v = $val;
            if (v < 1.0) v = 1.0;
            if (v > 3.0) v = 3.0;
            print v;
        }"
    }

    set_zoom() {
        local value="$1"
        clamped=$(clamp "$value")
        hyprctl keyword cursor:zoom_factor "$clamped"
    }

    case "$1" in
        reset)
            set_zoom 1.0
            ;;
        increase)
            if [[ -z "$2" ]]; then
                echo "Usage: $0 increase STEP"
                exit 1
            fi
            current=$(get_zoom)
            new=$(awk "BEGIN { print $current + $2 }")
            set_zoom "$new"
            ;;
        decrease)
            if [[ -z "$2" ]]; then
                echo "Usage: $0 decrease STEP"
                exit 1
            fi
            current=$(get_zoom)
            new=$(awk "BEGIN { print $current - $2 }")
            set_zoom "$new"
            ;;
        *)
            echo "Usage: $0 {reset|increase STEP|decrease STEP}"
            exit 1
            ;;
    esac
  '';

  home.activation.makeZoomExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    chmod +x ${config.home.homeDirectory}/.config/hypr/hyprland/scripts/zoom.sh
  '';
}
