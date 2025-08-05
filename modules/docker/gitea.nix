{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers = {
    gitea = {
      image = "gitea/gitea:latest";
      autoStart = true;
      hostname = "gitea";
      ports = [ 
      #  "3000:3000" 
        "222:22" 
      ];
      networks = [ "traefik" ];
      volumes = [ "/swarm/gitea/data:/data" ];
      environment = {
        USER_UID = "1000";
        USER_GID = "1000";
        GITEA__database__DB_TYPE = "mysql";
        GITEA__database__HOST = "mysql:3306";
        GITEA__database__NAME = "gitea";
        GITEA__database__USER = "gitea";
        GITEA__database__PASSWD = "giteapass";
      };
      dependsOn = [ "mysql" ];
    };

    mysql = {
      image = "mysql:8.0";
      autoStart = true;
      environment = {
        MYSQL_ROOT_PASSWORD = "supersecret";
        MYSQL_DATABASE = "gitea";
        MYSQL_USER = "gitea";
        MYSQL_PASSWORD = "giteapass";
      };
      volumes = [ "/swarm/gitea/mysql:/var/lib/mysql" ];
    };
  };
}
