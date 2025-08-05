{ config, lib, pkgs, ... }:

let
  envContent = ''
# Database
POSTGRES_PASSWORD=postgres
POSTGRES_USER=postgres
POSTGRES_DB=joplin

# Joplin App
APP_PORT=22300
APP_BASE_URL=https://joplin.local.geniehome.net
DB_CLIENT=pg
POSTGRES_DATABASE=joplin
POSTGRES_PORT=5432
POSTGRES_HOST=db
  '';
in {
  config.system.activationScripts.joplinEnv = {
    text = ''
      mkdir -p /swarm/joplin
      cat > /swarm/joplin/.env <<EOF
${envContent}
EOF
    '';
  };
}

