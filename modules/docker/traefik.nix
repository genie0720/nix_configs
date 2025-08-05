{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers.traefik = {
    image = "traefik:latest";
    hostname = "traefik";
    environmentFiles = [ "/swarm/traefik/.env" ];
    networks = [ "traefik" ];
    ports = [
      "80:80"
      "443:443"
    ];

    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock:ro"
      "/swarm/traefik/data/traefik.yml:/traefik.yml:ro"
      "/swarm/traefik/data/acme.json:/acme.json"
      "/swarm/traefik/data/config.yml:/config.yml:ro"
      "/swarm/traefik/logs:/var/log/traefik"
    ];

  };
}