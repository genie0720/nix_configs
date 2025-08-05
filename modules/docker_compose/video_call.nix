{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services.video_calls = {
      description = "Run Docker Compose for video_calls";
      after = [ "network.target" "docker.service" ];
      requires = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";

        # Pull the latest image before running
        ExecStartPre = "/run/current-system/sw/bin/docker compose -f /swarm/video_calls/compose.yaml pull";

        # Bring the service up
        ExecStart = "/run/current-system/sw/bin/docker compose -f /swarm/video_calls/compose.yaml up";

        # Take it down gracefully
        ExecStop = "/run/current-system/sw/bin/docker compose -f /swarm/video_calls/compose.yaml down";

        WorkingDirectory = "/swarm/video_calls";
        Restart = "on-failure";
      };
    };
  };
}