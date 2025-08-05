{ config, lib, pkgs, ... }:

let
  cfg = config.immich.env;

  envContent = ''
    # You can find documentation for all the supported env variables at https://immich.app/docs/install/environment-variables

    UPLOAD_LOCATION=${cfg.uploadLocation}
    DB_DATA_LOCATION=/swarm/immich/postgres
    # TZ=Etc/UTC
    IMMICH_VERSION=release
    DB_PASSWORD=postgres
    DB_USERNAME=postgres
    DB_DATABASE_NAME=immich
  '';
in {
  options.immich.env = {
    enable = lib.mkEnableOption "Generate Immich .env file";

    uploadLocation = lib.mkOption {
      type = lib.types.str;
      default = "/media/media/immich";
      description = "Path where uploaded files are stored";
    };
  };

  config = lib.mkIf cfg.enable {
    system.activationScripts.immichEnv = {
      text = ''
        mkdir -p /swarm/immich
        cat > /swarm/immich/.env <<EOF
${envContent}
EOF
      '';
    };
  };
}

