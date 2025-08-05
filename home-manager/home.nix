{ config, pkgs, ... }:

{
  
  imports = [
    ./modules/zsh.nix
    ./modules/cursor.nix
    ./modules/ssh-config.nix
    ./modules/git.nix
    ./modules/htop.nix
    ./modules/alacritty.nix
    ./modules/qt.nix
    ./modules/swww.nix
    ./modules/wms/hyprland.nix
    ./modules/wms/waybar.nix
   # ./modules/wms/hyprlock.nix
  #  ./modules/wms/swaylock.nix
   # ./modules/wms/swayidle_toggle.nix
   # ./modules/wms/hypridle.nix
    ./.config/wlogout/bundle_wlogout.nix
    
    #./modules/wms/wlogout/wlogout.nix
    #./modules/wms/wlogout/style.nix

        # hypr
    ./.config/hypr/hyprlock/bundle_hyprlock.nix
    ./.config/hypr/shaders/bundle_shaders.nix
    ./.config/hypr/hypridle.nix
    ./.config/hypr/hyprlock.nix


    
  ];
  #disabledModules = [
   # "services/hypridle.nix"
 # ];
  #services.hypridle = {
  #enable = true;
  #settings = {
   # general = {
   #   lock_cmd = "${config.home.homeDirectory}/.config/swaylock/lock.sh";
    #  after_sleep_cmd = "hyprctl dispatch dpms on";
    #  ignore_dbus_inhibit = false;
  #  };

  #  listener = [
   #   {
    #    timeout = 300;
    #    on-timeout = "${config.home.homeDirectory}/.config/swaylock/lock.sh";
    #  }
    #  {
    #    timeout = 600;
    # on-timeout = "hyprctl dispatch dpms off";
    #  on-resume = "hyprctl dispatch dpms on";
    #  }
  #  ];
#  };
#};

  
  home.username = "genie";
  home.homeDirectory = "/home/genie";
  home.sessionVariables = {
   # PATH = "$HOME/.nix-profile/bin:$PATH";
  };

  home.stateVersion = "24.11"; # Adjust to match your system version
  #programs.home-manager.enable = true;
}
