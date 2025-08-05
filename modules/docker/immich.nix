{ config, pkgs, lib, ... }:

{
  virtualisation.oci-containers.containers = {
    immich-server = {
      image = "ghcr.io/immich-app/immich-server:latest;
      hostname = "immich_server";
      volumes = [
        "/media/media/immich:/usr/src/app/upload"
        "/etc/localtime:/etc/localtime:ro"
      ];
      environmentFiles = [ "/swarm/immich/.env" ];
      networks = [ "traefik" "immich" ];
      dependsOn = [ "redis" "database" ];
      #healthcheck = {
       # disable = false;
      #};
    };

    immich-machine-learning = {
      image = "ghcr.io/immich-app/immich-machine-learning:latest";
      hostname = "immich_machine_learning";
      volumes = [ "/swarm/immich/model-cache:/cache" ];
      environmentFiles = [ "/swarm/immich/.env" ];
      networks = [ "immich" ];
      #healthcheck = {
       # disable = false;
      #};
    };

    redis = {
      image = "docker.io/valkey/valkey:8-bookworm@sha256:42cba146593a5ea9a622002c1b7cba5da7be248650cbb64ecb9c6c33d29794b1";
      hostname = "immich_redis";
      networks = [ "immich" ];
      #healthcheck = {
      #cmd = [ "redis-cli ping || exit 1" ];
     # };
    };

    database = {
      image = "docker.io/tensorchord/pgvecto-rs:pg14-v0.2.0@sha256:739cdd626151ff1f796dc95a6591b55a714f341c737e27f045019ceabf8e8c52";
      hostname = "immich_postgres";
      networks = [ "immich" ];
      environmentFiles = [ "/swarm/immich/.env" ];
      volumes = [ "/swarm/immich/postgres:/var/lib/postgresql/data" ];
      #healthcheck = {
      #cmd = [
      #    "pg_isready --dbname=$${POSTGRES_DB} --username=$${POSTGRES_USER} || exit 1"
       #   "Chksum=$$(psql --dbname=$${POSTGRES_DB} --username=$${POSTGRES_USER} --tuples-only --no-align --command='SELECT COALESCE(SUM(checksum_failures), 0) FROM pg_stat_database')"
       #    "[ $$Chksum = '0' ] || exit 1"
      #     ];
       # interval = "5m";
        #startInterval = "30s";
       # startPeriod = "5m";
     # };
      cmd = [
        "--shared-preload-libraries=vectors.so"
        "--search_path=$$user, public, vectors"
        "--logging_collector=on"
        "--max_wal_size=2GB"
        "--shared_buffers=512MB"
        "--wal_compression=on"
       # "pg_isready --dbname=$${POSTGRES_DB} --username=$${POSTGRES_USER} || exit 1"
         # "Chksum=$$(psql --dbname=$${POSTGRES_DB} --username=$${POSTGRES_USER} --tuples-only --no-align --command='SELECT COALESCE(SUM(checksum_failures), 0) FROM pg_stat_database')"
          #"echo 'checksum failure count is $$Chksum'"
         # "[ $$Chksum = '0' ] || exit 1"
      ];
    };
  };
}