{ config, ... }:

{
  home.file = {
    "${config.home.homeDirectory}/.config/swaylock/lock.sh" = {
      text = ''
        #!/usr/bin/env bash
        swaylock \
          --effect-blur 7x5 \
          --clock \
          --indicator \
          --screenshots \
          --ring-color 3b82f6 \
          --text-color ffffff
      '';
      executable = true;
    };
  };
}
