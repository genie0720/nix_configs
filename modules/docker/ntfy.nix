{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers = {
  
  ntfy = {
    image = "binwiederhier/ntfy";
    hostname = "ntfy";
    environmentFiles = [ "/swarm/ntfy/.env" ];
    networks = [ "traefik" ];
    cmd = [ "serve" ];
    # ports = [
    # "80:80"
    #];
    volumes = [
      "/swarm/ntfy/cache:/var/cache/ntfy"
      "/swarm/ntfy/etc:/etc/ntfy"
    ];
  };
};
}