{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers.ytptube = {
    image = "ghcr.io/arabcoders/ytptube:latest";
    hostname = "ytptube";
    user = "1000:1000";
    # environmentFiles = [ "/swarm/ytptube/.env" ];
    networks = [ "traefik" ];
    # ports = [
    # "8081:8081"
    #];

    volumes = [
      "/media/ytptube:/downloads"
      "/swarm/ytptube/config:/config"
    ];

  };
}