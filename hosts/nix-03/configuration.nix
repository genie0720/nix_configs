{ config, pkgs, lib, inputs, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # System core modules
      ../../modules/base.nix
      ../../modules/system/bootloader.nix
      ../../modules/system/ssh.nix
      ../../modules/system/firewall.nix
      ../../modules/system/swarm_mount.nix
      ../../modules/system/media_mount.nix
      ../../modules/system/smb.nix

      # User and Homemanager modules
      ../../modules/users/nix.nix
      inputs.home-manager.nixosModules.default
      
      # Docker and Docker Compose modules
      ../../modules/docker_compose/immich/immich.nix
      ../../modules/docker_compose/immich/env.nix
      ../../modules/docker_compose/crowdsec.nix
      ../../modules/docker/jellyfin.nix
      ../../modules/docker_compose/ytptube.nix
      ../../modules/docker_compose/nextpvr.nix
      ../../modules/docker_compose/periphery3.nix
      
  ];

  immich.env = {
    enable = true;
    uploadLocation = "/media/media/immich";
  };

  # Define the system hostname
  networking.hostName = "nix03";

}
