{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers.homarr = {
    image = "ghcr.io/homarr-labs/homarr:latest";
    hostname = "homarr";
    environmentFiles = [ "/swarm/homarr/.env" ];
    networks = [ "traefik" ];
    # ports = [
    # "7575:7575"
    #];

    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "/swarm/homarr/appdata:/appdata"
    ];

  };
}