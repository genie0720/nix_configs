{ inputs, ... }: {
  
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # System core modules
      ../../modules/base.nix
      ../../modules/system/desktop.nix
      ../../modules/system/ssh.nix
      ../../modules/system/firewall.nix
      ../../modules/system/xrdp.nix
      ../../modules/system/steam.nix
      ../../modules/system/packages.nix
      ../../modules/system/smb_mount.nix
     

      # User and Homemanager modules
      ../../modules/users/genie.nix
      inputs.home-manager.nixosModules.default
      
  ];

  # Define the system hostname
  networking.hostName = "asusnix";

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
  };

  nixpkgs.overlays = [ inputs.polymc.overlay ];

    disabledModules = [
    ../../modules/system/xserver.nix
  ];
}