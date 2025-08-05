{ config, pkgs, lib, inputs, ... }:

{
  imports = [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # System core modules
      ../../modules/base.nix
      ../../modules/system/bootloader.nix
      ../../modules/system/nfs.nix
      ../../modules/system/ssh.nix
      ../../modules/system/firewall.nix

      # User and Homemanager modules
      ../../modules/users/nix.nix
      inputs.home-manager.nixosModules.default
      
      # Docker and Docker Compose modules
      ../../modules/docker/authentik.nix
      ../../modules/docker_compose/gitea.nix
      ../../modules/docker_compose/komodo.nix
      ../../modules/docker_compose/traefik.nix
      
  ];

  # Define the system hostname
  networking.hostName = "nix01";

}
