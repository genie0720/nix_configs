{config, pkgs, lib, inputs, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # System core modules
      ../../modules/base.nix
      ../../modules/system/ssh.nix
      ../../modules/system/firewall.nix
      ../../modules/system/bootloader.nix
      # ../../modules/system/swarm_mount.nix

      # User and Homemanager modules
      ../../modules/users/nix.nix
      inputs.home-manager.nixosModules.default
      
      # Docker and Docker Compose modules
      ../../modules/docker_compose/immich/immich.nix
      ../../modules/docker_compose/immich/env.nix
      
  ];

  # Define the system hostname
  networking.hostName = "nix-test";

} 
