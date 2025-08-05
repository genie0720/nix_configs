 { config, pkgs, lib, ... }:

 {

  imports = [
    ./bluetooth.nix
    ./env.nix
    ./hyprland.nix
    ./sound.nix
    ./trim.nix
    ./virtmanager.nix
   # ./xserver.nix
    ./zram.nix
    #./swayidle.nix
  ];   
   
   # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nvidia Settings
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # proprietary driver for full performance
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
 
  hardware.opengl = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

 }
