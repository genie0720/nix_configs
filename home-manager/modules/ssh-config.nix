{
    programs.ssh = {
    enable = true;
    matchBlocks = {
      "1nix" = {
        hostname = "192.168.20.3";
        user = "nix";
      };
      "2nix" = {
        hostname = "192.168.20.4";
        user = "nix";
      };
      "3nix" = {
        hostname = "192.168.20.5";
        user = "nix";
      };
      "prox" = {
        hostname = "192.168.20.10";
        user = "root";
      };
      "dns" = {
        hostname = "192.168.20.15";
        user = "dns";
      };
      "gitea.local.geniehome.net" = {
        hostname = "gitea.local.geniehome.net";
        port = 222;
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}