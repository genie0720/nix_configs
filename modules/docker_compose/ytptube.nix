{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services.ytptube = {
      description = "Run Docker Compose for ytptube";
      after = [ "network.target" "docker.service" ];
      requires = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";

        # Pull the latest image before running
        ExecStartPre = "/run/current-system/sw/bin/docker compose -f /swarm/ytptube/compose.yaml pull";

        # Bring the service up
        ExecStart = "/run/current-system/sw/bin/docker compose -f /swarm/ytptube/compose.yaml up";

        # Take it down gracefully
        ExecStop = "/run/current-system/sw/bin/docker compose -f /swarm/ytptube/compose.yaml down";

        WorkingDirectory = "/swarm/ytptube";
        Restart = "on-failure";
      };
    };
  };
}