{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers = {
  
  jellyfin = {
    image = "jellyfin/jellyfin:latest";
    hostname = "jellyfin";
    environmentFiles = [ "/swarm/jellyfin/.env" ];
    networks = [ "traefik" ];
    # ports = [
    # "8096:8096"
    #];
    volumes = [
      "/swarm/jellyfin/config:/config"
      "/swarm/jellyfin/cache:/cache"
      "/media/Movies:/movies"
      "/media/tv_shows:/tv_shows"
      "/media/family_videos:/family_videos"
      "/media/Music:/music"
      "/media/ytptube/youtube:/youtube"
      "/media/ytptube/music:/youtube_music"
      "/media/nextpvr/videos:/nextpvr"
      "/media/ytptube:/ytptube"
    ];
  };
};
}
