{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers = {
  
  db = {
    image = "postgres:16";
    #hostname = "joplin-db";
    environmentFiles = [ "/swarm/joplin/.env" ];
    networks = [ "joplin-internal" ];
    # ports = [
    # "5432:5432"
    #];
    volumes = [
      "/swarm/joplin/postgres:/var/lib/postgresql/data"
    ];
  };
  
  app = {
    image = "joplin/server:latest";
    hostname = "joplin";
    environmentFiles = [ "/swarm/joplin/.env" ];
    networks = [ "traefik" "joplin-internal" ];
    dependsOn = [ "db" ];
    # ports = [
    # "22300:22300"
    #];
    
  };
  };
}