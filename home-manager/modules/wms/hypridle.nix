{ config, lib, pkgs, ... }:

let
  cfg = config.services.hypridle;
in {
  options.services.hypridle = {
    enable = lib.mkEnableOption "Enable Hypridle for idle handling";

    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Configuration settings for Hypridle.";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."hypr/hypridle.conf".text = ''
      general {
        lock_cmd = ${cfg.settings.general.lock_cmd or hyprlock};
        after_sleep_cmd = ${cfg.settings.general.after_sleep_cmd or "hyprctl dispatch dpms on"};
        ignore_dbus_inhibit = ${lib.boolToString (cfg.settings.general.ignore_dbus_inhibit or false)};
      }

      ${lib.concatStringsSep "\n" (
        map (listener: ''
          listener {
            timeout = ${toString listener.timeout}
            on-timeout = ${listener.on-timeout};
            ${lib.optionalString (lib.hasAttr "on-resume" listener) "on-resume = ${listener.on-resume};"}
          }
        '') (cfg.settings.listener or [])
      )}
    '';

    systemd.user.services.hypridle = {
      Unit = {
        Description = "Hyprland Idle Manager";
        PartOf = [ "graphical-session.target" ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "${pkgs.hypridle}/bin/hypridle";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
