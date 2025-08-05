{ config, pkgs, ... }:

{
  users.users.genie = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Genie";
    extraGroups = [ "networkmanager" "docker" "wheel" "libvirtd" ];
    packages = with pkgs; [ 
      bitwarden-desktop
      neovim
      kitty
      vscode
      obs-studio
      xrdp 
    ];

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0D1YLuDTgEHw4ISwbh6G6E733JidD0/gervoPIK4Aq"
    #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0Ki5/j2JS6Aiovc8SrNuC5rKVwwVcaXmsOTIWHpD8B"
    ];
  };

  # Enable automatic login for the user.
  #services.getty.autologinUser = "genie";
}