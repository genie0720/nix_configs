{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services.gitea = {
      description = "Run Docker Compose for gitea";
      after = [ "network.target" "docker.service" ];
      requires = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";

        # Pull the latest image before running
        ExecStartPre = "/run/current-system/sw/bin/docker compose -f /swarm/gitea/compose.yaml pull";

        # Bring the service up
        ExecStart = "/run/current-system/sw/bin/docker compose -f /swarm/gitea/compose.yaml up";

        # Take it down gracefully
        ExecStop = "/run/current-system/sw/bin/docker compose -f /swarm/gitea/compose.yaml down";

        WorkingDirectory = "/swarm/gitea";
        Restart = "on-failure";
      };
    };
  };
}