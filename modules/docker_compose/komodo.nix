{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services.komodo = {
      description = "Run Docker Compose for komodo";
      after = [ "network.target" "docker.service" ];
      requires = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";

        # Pull the latest image before running
        ExecStartPre = "/run/current-system/sw/bin/docker compose -f /swarm/komodo/compose.yaml pull";

        # Bring the service up
        ExecStart = "/run/current-system/sw/bin/docker compose -f /swarm/komodo/compose.yaml up";

        # Take it down gracefully
        ExecStop = "/run/current-system/sw/bin/docker compose -f /swarm/komodo/compose.yaml down";

        WorkingDirectory = "/swarm/komodo";
        Restart = "on-failure";
      };
    };
  };
}