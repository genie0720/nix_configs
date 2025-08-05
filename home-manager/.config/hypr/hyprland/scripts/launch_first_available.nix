{ config, pkgs, lib, ... }:

{
  home.file.".config/hypr/hyprland/scripts/launch_first_available.sh".text = ''
    #!/usr/bin/env bash
    for cmd in "$@"; do
        eval "command -v ${cmd%% *}" >/dev/null 2>&1 || continue
        eval "$cmd" &
        exit
    done
    exit 1
  '';

  # Optional: make it executable at build time
  home.activation.makeLaunchScriptExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    chmod +x ${config.home.homeDirectory}/.config/hypr/hyprland/scripts/launch_first_available.sh
  '';
}
