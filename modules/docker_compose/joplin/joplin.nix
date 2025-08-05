{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services.joplin = {
      description = "Run Docker Compose for joplin";
      after = [ "network.target" "docker.service" ];
      requires = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";

        # Pull the latest image before running
        ExecStartPre = "/run/current-system/sw/bin/docker compose -f /swarm/joplin/compose.yaml pull";

        # Bring the service up
        ExecStart = "/run/current-system/sw/bin/docker compose -f /swarm/joplin/compose.yaml up";

        # Take it down gracefully
        ExecStop = "/run/current-system/sw/bin/docker compose -f /swarm/joplin/compose.yaml down";

        WorkingDirectory = "/swarm/joplin";
        Restart = "on-failure";
      };
    };
  };
}
