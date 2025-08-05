{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services.periphery = {
      description = "Run Docker Compose for komodo-periphery";
      after = [ "network.target" "docker.service" ];
      requires = [ "docker.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "exec";  # Ensures systemd tracks the correct process
        ExecStart = "/run/current-system/sw/bin/docker compose -f /swarm/periphery3/compose.yaml up";
        ExecStop = "/run/current-system/sw/bin/docker compose -f /swarm/periphery3/compose.yaml down";
        Restart = "on-failure";  # Prevents unnecessary restart loops
      };
    };
  };
}