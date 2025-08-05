{ config, pkgs, ... }:

let
  scriptName = "change_wall.sh";
  scriptPath = "${config.home.homeDirectory}/.config/swww/${scriptName}";
in {
  home.packages = [ pkgs.swww ];

  home.file.${scriptPath} = {
    text = ''
      #!/bin/bash
      WALLPAPER_DIR="$HOME/Wallpaper-Bank/wallpapers"
      WALL=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
      swww img --transition-type fade --transition-duration 1 "$WALL"
    '';
    executable = true;
  };
}
