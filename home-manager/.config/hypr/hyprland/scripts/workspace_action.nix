{ config, pkgs, lib, ... }:

{
  home.file.".config/hypr/hyprland/scripts/workspace_action.sh".text = ''
    #!/usr/bin/env bash
    hyprctl dispatch "$1" $(((($(hyprctl activeworkspace -j | jq -r .id) - 1)  / 10) * 10 + $2))
  '';

  home.activation.makeWorkspaceExecutable = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    chmod +x ${config.home.homeDirectory}/.config/hypr/hyprland/scripts/workspace_action.sh
  '';
}
