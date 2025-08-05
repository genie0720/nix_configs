{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers.kuma = {
    image = "louislam/uptime-kuma:latest";
    hostname = "kuma";
    #environmentFiles = [ "/swarm/kuma/.env" ];
    networks = [ "traefik" ];
    # ports = [
    # "3001:3001"
    #];

    volumes = [
      #"/var/run/docker.sock:/var/run/docker.sock"
      "/swarm/kuma/data:/app/data"
    ];

  };
}